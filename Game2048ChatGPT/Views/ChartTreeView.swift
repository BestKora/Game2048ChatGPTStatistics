//
//  ChartTreeView.swift
//  My2048New
//
//  Created by Tatiana Kornilova on 21.03.2024.
//

import SwiftUI
import Charts
import SwiftData

//-------------------------
struct MaxTileFrequencyExp: Identifiable {
    let maxTile: Int
    let zeroWeight: Double
    let count: Int
    var id: Int { maxTile.hashValue ^ zeroWeight.hashValue }
    var avrScore: Int = 0
    var animate: Bool = false
}

struct MaxTileZeroWeigtKey: Hashable {
    let maxTile: Int
    let zeroWeight: Double
}
//---------------------------
struct ChartTreeView: View {
    @Query(sort: \TreeSearch.time, order: .forward)  var expectimaxs: [TreeSearch]
    @State private var algorithm: String = "All"
    //---- animate ----
    @State var sampleAnalitics: [String: [MaxTileFrequencyExp]]  = [:]
    //----------------
    
    var filteredExpectimaxs: [TreeSearch] {
        if algorithm == "All" { return expectimaxs }
        return expectimaxs.compactMap { item in
            return item.algorithm == algorithm ? item : nil
        }
    }
    
    var maxTileFrequencyByZeroWeight: [MaxTileFrequencyExp] {
        let groupedData = Dictionary(
            grouping: filteredExpectimaxs,
            by: { MaxTileZeroWeigtKey(maxTile: $0.maxTile, zeroWeight: $0.zeroWeight) }
        )
        
        return groupedData.map { key, results in
            MaxTileFrequencyExp(
                maxTile: key.maxTile,
                zeroWeight: key.zeroWeight,
                count: results.count,
                avrScore: results.map{$0.score}.average() / 1000
            )
        }
        .sorted { $0.maxTile < $1.maxTile }
    }
 
    var groupedData: [String: [MaxTileFrequencyExp]] {
        Dictionary(grouping: maxTileFrequencyByZeroWeight, by: { String($0.zeroWeight)})
    }

    var marks:  [String] {
        Array(Set(maxTileFrequencyByZeroWeight.map { $0.maxTile })).map {String($0)}.sorted { Int($0)! < Int($1)! }
    }

    var body: some View {
            VStack {
                HStack {
                    Text ("Algorithm:")
                    Picker( selection: $algorithm, label: Text("")) {
                        ForEach(["All","Expectimax", "ExpectiMAsync"], id: \.self) { algorithm in
                            Text("\(algorithm)").tag("\(algorithm)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.leading, 10)
                }
                .padding(.bottom)
             //---------------------------------------------------------------
                Section(header: Text("Number of MaxTile").font(.subheadline)) {
                    AnimatedChart
                }
             //---------------------------------
                Section(header: Text("Average of score").font(.subheadline)) {
                    AnimatedChartAverage
                }
            //----------------------------------------------------------------------
        }// VStack
            .onChange(of: algorithm) { oldValue, newValue in
                sampleAnalitics =  groupedData
                // Re - Animating View
                animateGraph(fromChange: true)
            }
            .padding()
    } // body
    
    private var AnimatedChart: some View {
       let max = sampleAnalitics.values.flatMap{$0}.map{$0.count}.max () ?? 0
       return Chart {
            ForEach( sampleAnalitics.keys.sorted {Double($0)! < Double($1)!} , id:\.self) { element in
                ForEach(sampleAnalitics[element]!, id: \.maxTile) { stat in
                    BarMark(
                        x: .value("MaxTile", String(stat.maxTile)),
                        y: .value("Count",  stat.animate ? stat.count : 0)//stat.count)
                    )
                    .annotation (position: .top) {
                        Text(String(stat.count))
                            .foregroundColor(.black)
                            .font(.footnote)
                    }
                }
                .foregroundStyle(by: .value("Simulations", element))
                .position(by: .value("Simulations", element))
            }
        }
        // MARK: Customizing Y-Axis Length
        .chartYScale(domain: 0...(max ) )
        // MARK: Customizing X-Axis Length
        .chartXScale(domain: marks)
        .aspectRatio(1, contentMode: .fit)
        .padding()
        //----- animate -------
        .onAppear{
            animateGraph()
         } // onAppear
    }
    
    private var AnimatedChartAverage: some View {
        let max = sampleAnalitics.values.flatMap{$0}.map{$0.avrScore}.max () ?? 0
         return Chart {
             ForEach( sampleAnalitics.keys.sorted {Double($0)! < Double($1)!} , id:\.self) { element in
                 ForEach(sampleAnalitics[element]!, id: \.maxTile) { stat in
                 
                     BarMark(
                         x: .value("MaxTile", String(stat.maxTile)),
                         y: .value("Count",  stat.animate ? stat.avrScore : 0)//stat.avrScore)
                     )
                     .annotation (position: .top) {
                         Text(String(stat.avrScore))
                             .foregroundColor(.black)
                             .font(.footnote)
                     }
                 }
                 .foregroundStyle(by: .value("Simulations", element))
                 .position(by: .value("Simulations", element))
             }
         }
         // MARK: Customizing Y-Axis Length
         .chartYScale(domain: 0...(max ) )
         // MARK: Customizing X-Axis Length
         .chartXScale(domain: marks)
         .aspectRatio(1, contentMode: .fit)
         .padding()
    }
    //------- animate ----
    func animateGraph(fromChange: Bool = false) {
        sampleAnalitics = groupedData
        
        for  key in groupedData.keys.sorted(by: {Double($0)! < Double($1)!})  {
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
}

#Preview {
    ChartTreeView()
        .modelContainer(previewContainer)
}
