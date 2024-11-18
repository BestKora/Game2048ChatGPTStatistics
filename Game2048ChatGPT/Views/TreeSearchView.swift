//
//  TreeSearchView.swift
//  My2048New
//
//  Created by Tatiana Kornilova on 18.03.2024.
//

import SwiftUI
import SwiftData

struct TreeSearchView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \TreeSearch.time, order: .forward)  var items: [TreeSearch]
    var body: some View {
        NavigationStack {
            List {
                ForEach(groupByZeroWeight(items), id: \.0) { montes in
                       Section(header: Text("\(String(montes.0))  \(montes.1.count)")) {
                               ForEach(montes.1) { item in
                                 
                                   let s = String(format: "%2.2f",item.zeroWeight)
                                   HStack{
                                       Text( "**\(item.maxTile)**").foregroundColor(.purple)
                                       Text(item.time.formatted(date: .numeric, time: .shortened))
                                       Text("**\(item.score)**")
                                           .foregroundColor(.blue)
                                       Text("**\(s)**")
                                           .foregroundColor(.red)
                                   }
                               }
                           }
                       }
                   }
            .listStyle(.plain)
            .navigationTitle("Expectimax  (\(items.count))")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) { write}
                ToolbarItem(placement: .topBarLeading) {read}
            }
        } .task {
            if items.count == 0 {
                await asyncLoad()  // background actor
            }
        }
    }
    
    private func asyncLoad () async {  // actor
        let actor = LoadModelActor(modelContainer: context.container)
       // await actor.monteCarlosAsync (FilesJSON.monteCarlosFile)
        await actor.treeSearchAsync (FilesJSON.treeSearchFile)
    }
    
    func groupByZeroWeight(_ items: [TreeSearch]) -> [(Double, [TreeSearch])] {
        let grouped = Dictionary(grouping: items, by: { $0.zeroWeight })
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
        let fileUrl = URL.documentsDirectory.appendingPathComponent("algorithmData.json")
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
            try! jsonData.write(to: fileUrl)
        }
            print(" JSON file URL:")
            print(fileUrl)
    }
    private func readJSON () {
        let fileUrl = URL.documentsDirectory.appendingPathComponent("algorithmData.json")
        do {
                let data = try Data(contentsOf: fileUrl)
                let decoder = JSONDecoder()
            //----
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            decoder.dateDecodingStrategy = .iso8601
            //----
                let treeSearches = try decoder.decode([TreeSearch].self, from: data)
            print ("ITEMS  \(treeSearches[0].score)")
            print("JSON file URL: \(fileUrl)")
            } catch {
                print("Error reading JSON file: \(error.localizedDescription)")
                print("JSON file URL: \(fileUrl)")
            }
    }
}

#Preview {
    TreeSearchView()
        .modelContainer(previewContainer)
}
