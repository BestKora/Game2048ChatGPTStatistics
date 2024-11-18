//
//  ChatViewNew.swift
//  My2048New
//
//  Created by Tatiana Kornilova on 27.06.2024.
//

import SwiftUI
import Charts
import SwiftData

//-------------------------
struct MaxTileFrequency: Identifiable {
    let maxTile: Int
    let simulations: Int
    let count: Int
    var id: Int { maxTile.hashValue ^ simulations.hashValue }
    var animate: Bool = false
}

struct MaxTileSimulationKey: Hashable {
    let maxTile: Int
    let simulations: Int
}
//----------------------
struct ChartViewNew: View {
    @Query(sort: \MonterCarloNew.time, order: .forward)  var monteCarlos: [MonterCarloNew]
   
    @State private var zerosWeightMC: String = "All"
    //---- animate ----
    @State var sampleAnalitics: [Int: [MaxTileFrequency]]  = [:]
    //----------------
    
    var filteredMonteCarlos: [MonterCarloNew] {
        if zerosWeightMC == "All" { return monteCarlos }
            return monteCarlos.compactMap { item in
                return item.zerosWeightMC == Int(zerosWeightMC) ? item : nil
            }
        }
   
    var maxTileFrequencyBySimulations: [MaxTileFrequency] {
        let groupedData = Dictionary(
            grouping: filteredMonteCarlos,
            by: { MaxTileSimulationKey(maxTile: $0.maxTile, simulations: $0.numberSimulations ) }
        )
        
        return groupedData.map { key, results in
            MaxTileFrequency(
                maxTile: key.maxTile,
                simulations: key.simulations,
                count: results.count
            )
        }
        .sorted { $0.maxTile < $1.maxTile }
    }
    
    var groupedData: [Int: [MaxTileFrequency]] {
        Dictionary(grouping: maxTileFrequencyBySimulations, by: { $0.simulations})
    }
   
    var marks:  [String] {
        Array(Set(maxTileFrequencyBySimulations.map { $0.maxTile })).map {String($0)}.sorted { Int($0)! < Int($1)! }
    }
    //-----
    
    var body: some View {
        VStack {
            VStack {
                Text ("Zeros Weight:")
                Picker( selection: $zerosWeightMC, label: Text("")) {
                    ForEach(["All", "1024", "2048", "4096", "8192", "16384"], id: \.self) { weightMC in
                        Text("\(weightMC)").tag("\(weightMC)")
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
            AnimatedChart
        } // VStack
        .onChange(of: zerosWeightMC) { oldValue, newValue in
            sampleAnalitics =  groupedData
            // Re - Animating View
            animateGraph(fromChange: true)
        }
    } // body
    
    private var AnimatedChart: some View {
        let max = sampleAnalitics.values.flatMap{$0}.map{$0.count}.max () ?? 0
       return Chart {
            
          //  ForEach( groupedData.keys.sorted() , id:\.self) { simulation in
              ForEach( sampleAnalitics.keys.sorted() , id:\.self) { simulation in
                  
            //   ForEach(groupedData[simulation]!, id: \.maxTile) { item in
              ForEach(sampleAnalitics[simulation]!, id: \.maxTile) { item in
                  
                    BarMark(
                        x: .value("Max Tile", String(item.maxTile)),
                        y: .value("Count", item.animate ? item.count : 0)//item.count)
                    )
                    .annotation (position: .top) {
                        Text(String(item.count))
                            .foregroundColor(.black)
                            .font(.footnote)
                    }
                }
                .foregroundStyle(by: .value("Simulations", String(simulation)))
                .position(by: .value("Simulations", String(simulation)))
                
            }
        }
        // MARK: Customizing Y-Axis Length
        .chartYScale(domain: 0...(max ) )
        // MARK: Customizing X-Axis Length
        .chartXScale(domain: marks)
        .chartLegend(.visible)
        .aspectRatio(1, contentMode: .fit)
        .padding()
       .onAppear{
           animateGraph()
        } // onAppear
    } // some View
    
    //------- animate ----
    func animateGraph(fromChange: Bool = false) {
        sampleAnalitics = groupedData
        
        for  key in groupedData.keys.sorted() {
            if let bars =  groupedData [key] {
            for (index, _) in bars.enumerated() {
                
                // For Some Reason Delay is Not Working
                // Using DispatchQueue Delay
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * (fromChange ? 0.03 : 0.05)) {
                    withAnimation( fromChange ? .easeIn(duration: 0.8) : .interactiveSpring(response:0.8, dampingFraction: 0.8,blendDuration: 0.8)){
                        sampleAnalitics[key]! [index].animate = true
                        
                    } // with
                } // DispatchQueue
            } // for
        } // if
      } // for
    }// func
    //---------------------
} // View

#Preview {
    ChartViewNew()
        .modelContainer(previewContainer)
}
