//
//  MonteCarloView.swift
//  My2048New
//
//  Created by Tatiana Kornilova on 12.03.2024.
//

import SwiftUI
import SwiftData

struct MonteCarloView: View {
    @Query(sort: \MonterCarloNew.time, order: .forward)  var items: [MonterCarloNew]
    @Environment(\.modelContext) private var context
    @State private var zerosWeightMC: String = "All"
    
    var filteredItems: [MonterCarloNew] {
        if zerosWeightMC == "All" { return  items }
            return  items.compactMap { item in
                return item.zerosWeightMC == Int(zerosWeightMC) ? item : nil
            }
        }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text ("Zeros Weight:")
                Picker("", selection: $zerosWeightMC) {
                    ForEach(["All","1024", "2048", "4096", "8192","16384"], id: \.self) { weightMC in
                        Text("\(weightMC)").tag("\(weightMC)")
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
            List {        // zerosWeightMC
                ForEach(groupByNExperiments(filteredItems), id: \.0) { montes in
                    Section(header: Text("simulations = \(montes.0)   ZW = \(( montes.1.first?.zerosWeightMC)!)  \(montes.1.count)  ")) {
                               ForEach(montes.1) { item in
                                   HStack{
                                       Text( "**\(item.maxTile)**").foregroundColor(.purple)
                                       Text(item.time.formatted(date: .numeric, time: .shortened))
                                       Text("**\(item.score)**")
                                           .foregroundColor(.blue)
                                       Text("**\(item.zerosWeightMC)**")
                                           .foregroundColor(.red)
                                   }
                               }
                           }
                       }
                   }
            .listStyle(.plain)
            .navigationTitle("Monte Carlo (\(items.count))")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) { write}
                ToolbarItem(placement: .topBarLeading) {read}
            } // toolbar
        } //  Navigation
        .task {
            if items.count == 0 {
                await asyncLoad()  // background actor
            }
        } // task
    } // body
    
    private func asyncLoad () async {  // actor
        let actor = LoadModelActor(modelContainer: context.container)
        await actor.monteCarlosAsync (FilesJSON.monteCarlosFile)
      //  await actor.treeSearchAsync (FilesJSON.treeSearchFile)
    }
    
    func groupByNExperiments(_ items: [MonterCarloNew]) -> [(Int, [MonterCarloNew])] {
        let grouped = Dictionary(grouping: items, by: { $0.numberSimulations})
            return grouped.sorted(by: { $0.key < $1.key })
        }
    
    var write: some View {
        Button("Write") {
            Task  {
                writeJSON ()
            }
        }
    }
    var read: some View {
        Button("Read") {
            Task  {
                readJSON ()
            }
        }
    }
    
    private func writeJSON () {
            let encoder = JSONEncoder()
        //----
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .sortedKeys
        //----
            let jsonData = try! encoder.encode(items)
            // Write the JSON data to a file
        let fileUrl = URL.documentsDirectory.appendingPathComponent("monteDataNew.json")
        if String(data: jsonData, encoding: .utf8) != nil {
            try! jsonData.write(to: fileUrl)
        }
            print(" JSON file URL:")
            print(fileUrl)
    }
    private func readJSON () {
        let fileUrl = URL.documentsDirectory.appendingPathComponent("monteDataNew.json")
        do {
                let data = try Data(contentsOf: fileUrl)
                let decoder = JSONDecoder()
            //----
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            decoder.dateDecodingStrategy = .iso8601
            //----
                let carlos = try decoder.decode([MonterCarloNew].self, from: data)
            print ("ITEMS  \(carlos[0].score)")
            print("JSON file URL: \(fileUrl)")
            } catch {
                print("Error reading JSON file: \(error.localizedDescription)")
                print("JSON file URL: \(fileUrl)")
            }
    }
}

#Preview {
    MonteCarloView()
        .modelContainer(previewContainer)
}
