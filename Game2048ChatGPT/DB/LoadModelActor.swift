//
//  LoadModelActor.swift
//  SwiftData Airport2
//
//  Created by Tatiana Kornilova on 23.08.2023.
//

import Foundation
import SwiftData

actor LoadModelActor: ModelActor {
    let modelContainer: ModelContainer
    let modelExecutor: any ModelExecutor

  //  lazy var monteCarloTask  = Task {await monteCarlosAsync (FilesJSON.monteCarlosFile) }
  //  lazy var treeSearchTask  = Task {await treeSearchAsync (FilesJSON.treeSearchFile) }
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        let context = ModelContext(modelContainer)
        modelExecutor = DefaultSerialModelExecutor(modelContext: context)
      }
 //--------------------------------ASYNC MONTECARLO
    func monteCarlosAsync (_ nameJSON: String) async {
        var monteCarlos: [MonterCarloNew]? = []
        do {
            monteCarlos = try await FromJSONAPI.shared.fetchAsyncThrows (nameJSON)
            if let monteCarlosFA = monteCarlos {
                    for monteCarlo in monteCarlosFA {
                        modelContext.insert(monteCarlo)
                    }
                modelContext.saveContext()
            }
        } catch {
            print (" In file \(nameJSON) \(error)")
        }
    }
//-------------------------------------------------ASYNC TREESEARCH
   func treeSearchAsync (_ nameJSON: String) async {
       var treeSearchs: [TreeSearch]? = []
       do {
           treeSearchs = try await FromJSONAPI.shared.fetchAsyncThrows (nameJSON)
           if let treeSearchsFA = treeSearchs {
                   for treeSearch in treeSearchsFA {
                       modelContext.insert(treeSearch)
                   }
               modelContext.saveContext()
           }
       } catch {
           print (" In file \(nameJSON) \(error)")
       }
   }
}
//-------------------------------------------------------------
struct FilesJSON {
    static var monteCarlosFile = "monteDataNew"
    static var treeSearchFile = "algorithmData"
}
//-------------------------------------------------------------
struct LoadItems {
    var context : ModelContext
    init(context: ModelContext){
        self.context = context
    }
    //--------------------------------ASYNC MONTECARLO
           func monteCarlosAsync (_ nameJSON: String) async {
               var monteCarlos: [MonterCarloNew]? = []
               do {
                   monteCarlos = try await FromJSONAPI.shared.fetchAsyncThrows (nameJSON)
                   if let monteCarlosFA = monteCarlos {
                           for monteCarlo in monteCarlosFA {
                               context.insert(monteCarlo)
                           }
                       context.saveContext()
                   }
               } catch {
                   print (" In file \(nameJSON) \(error)")
               }
           }
    //-------------------------------------------------ASYNC TREESEARCH
       func treeSearchAsync (_ nameJSON: String) async {
           var treeSearchs: [TreeSearch]? = []
           do {
               treeSearchs = try await FromJSONAPI.shared.fetchAsyncThrows (nameJSON)
               if let treeSearchsFA = treeSearchs {
                       for treeSearch in treeSearchsFA {
                           context.insert(treeSearch)
                       }
                   context.saveContext()
               }
           } catch {
               print (" In file \(nameJSON) \(error)")
           }
       }
    //--------------------------------------------------------- Main Actor
    func asyncLoadMainActor () async {
        await monteCarlosAsync (FilesJSON.monteCarlosFile)      //-----monteCarlos
     //   await treeSearchAsync  (FilesJSON.treeSearchFile)     //-----TreeSearch
    }
    //--------------------------------------------------------------------
}

