//
//  Model.swift
//  SwidtData Airport
//
//  Created by Tatiana Kornilova on 16.06.2023.
//

import SwiftUI
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer (for: /*MonterCarlo.self, */TreeSearch.self,MonterCarloNew.self,
                        configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        SampleDataNew.monterCarlosInsert(context: container.mainContext)
        SampleDataNew.treeSearchesInsert(context: container.mainContext)
        return container
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()
/*
struct SampleData {
    // -----  1 ----
    static let monterCarlos: [MonterCarlo] = {
        let monterCarloData1: MonterCarlo  = {
            let monterCarlo = MonterCarlo(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 100, deep: 10, limitZeros: 4, maxTile: 2048, score: 29765, moves: 516)
            return monterCarlo
        } ()
        // -----  2 ----
        let monterCarloData2: MonterCarlo   = {
            let monterCarlo = MonterCarlo(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 100, deep: 10, limitZeros: 4, maxTile: 4096, score: 72924, moves: 516)
            return  monterCarlo
        } ()
        // -----  3 ----
        let monterCarloData3: MonterCarlo   = {
            let monterCarlo = MonterCarlo(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 100, deep: 10, limitZeros: 4, maxTile: 2048, score: 28668, moves: 516)
            return  monterCarlo
        } ()
        // -----  4 ----
        let monterCarloData4: MonterCarlo   = {
            let monterCarlo = MonterCarlo(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 100, deep: 10, limitZeros: 4, maxTile: 2048, score: 37168, moves: 516)
            return  monterCarlo
        } ()
        // -----  5 ----
        let monterCarloData5: MonterCarlo   = {
            let monterCarlo = MonterCarlo(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 100, deep: 10, limitZeros: 4, maxTile: 1024, score: 19765, moves: 516)
            return  monterCarlo
        } ()
        // -----  6 ----
            let monterCarloData6: MonterCarlo  = {
                let monterCarlo = MonterCarlo(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 2048, score: 46768, moves: 516)
                return monterCarlo
            } ()
            // -----  7 ----
            let monterCarloData7: MonterCarlo   = {
                let monterCarlo = MonterCarlo(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 4096, score: 62768, moves: 516)
                return  monterCarlo
            } ()
            // -----  8 ----
            let monterCarloData8: MonterCarlo   = {
                let monterCarlo = MonterCarlo(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 2048, score: 28668, moves: 516)
                return  monterCarlo
            } ()
            // -----  9 ----
            let monterCarloData9: MonterCarlo   = {
                let monterCarlo = MonterCarlo(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 2048, score: 36168, moves: 516)
                return  monterCarlo
            } ()
            // -----  10 ----
            let monterCarloData10: MonterCarlo   = {
                let monterCarlo = MonterCarlo(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 4096, score: 59765, moves: 516)
                return  monterCarlo
            } ()
        
        // -----  11 ----
        let monterCarloData11: MonterCarlo   = {
            let monterCarlo = MonterCarlo(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 1024, score: 19765, moves: 516)
            return  monterCarlo
        } ()
        
        // -----  12 ----
        let monterCarloData12: MonterCarlo   = {
            let monterCarlo = MonterCarlo(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 2048, score: 39765, moves: 516)
            return  monterCarlo
        } ()
        
        // -----  13 ----
        let monterCarloData13: MonterCarlo   = {
            let monterCarlo = MonterCarlo(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 100, deep: 10, limitZeros: 4, maxTile: 512, score: 9765, moves: 516)
            return  monterCarlo
        } ()
        return [monterCarloData1,monterCarloData2, monterCarloData3, monterCarloData4, monterCarloData5,monterCarloData6,monterCarloData7, monterCarloData8, monterCarloData9, monterCarloData10,monterCarloData11, monterCarloData12, monterCarloData13]
    }()
    
    static let treeSearches: [TreeSearch] = {
        // -----  1 ----
        let treeSearch1: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "Expectimax", time: Date.now, fourEstimate: false, zeroWeight: Constants.zerosWeight, zerosBeginning: Constants.zerosBeginning, maxTile: 2048, score: 35768, moves: 640)
            return treeSearch
        } ()
        // -----  2 ----
        let treeSearch2: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "Expectimax", time: Date.now, fourEstimate: false, zeroWeight: Constants.zerosWeight, zerosBeginning: Constants.zerosBeginning, maxTile: 2048, score: 48768, moves: 640)
            return treeSearch
        } ()
        // -----  3 ----
        let treeSearch3: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "Expectimax", time: Date.now, fourEstimate: false, zeroWeight: Constants.zerosWeight, zerosBeginning: Constants.zerosBeginning, maxTile: 2048, score: 35768, moves: 640)
            return treeSearch
        } ()
        
        return [treeSearch1, treeSearch2, treeSearch2]
    }()
    
    static func monterCarlosInsert(context: ModelContext) {
        monterCarlos.forEach{context.insert($0)}
    }
    static func treeSearchesInsert(context: ModelContext) {
        treeSearches.forEach{context.insert($0)}
    }
}*/

struct SampleDataNew {
    // -----  1 ----
    static let monterCarlos: [MonterCarloNew] = {
        let monterCarloData1: MonterCarloNew  = {
            let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 100, deep: 10, limitZeros: 4, maxTile: 2048, score: 29765, moves: 516, zerosWeightMC: 2048)
            return monterCarlo
        } ()
        // -----  2 ----
        let monterCarloData2: MonterCarloNew   = {
            let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 100, deep: 10, limitZeros: 4, maxTile: 4096, score: 72924, moves: 516,zerosWeightMC: 2048)
            return  monterCarlo
        } ()
        // -----  3 ----
        let monterCarloData3: MonterCarloNew   = {
            let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 100, deep: 10, limitZeros: 4, maxTile: 2048, score: 28668, moves: 516,zerosWeightMC: 2048)
            return  monterCarlo
        } ()
        // -----  4 ----
        let monterCarloData4: MonterCarloNew   = {
            let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 100, deep: 10, limitZeros: 4, maxTile: 2048, score: 37168, moves: 516,zerosWeightMC: 2048)
            return  monterCarlo
        } ()
        // -----  5 ----
        let monterCarloData5: MonterCarloNew = {
            let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 100, deep: 10, limitZeros: 4, maxTile: 1024, score: 19765, moves: 516,zerosWeightMC: 2048)
            return  monterCarlo
        } ()
        // -----  6 ----
            let monterCarloData6: MonterCarloNew  = {
                let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 2048, score: 46768, moves: 516,zerosWeightMC: 2048)
                return monterCarlo
            } ()
            // -----  7 ----
            let monterCarloData7: MonterCarloNew  = {
                let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 4096, score: 62768, moves: 516,zerosWeightMC: 2048)
                return  monterCarlo
            } ()
            // -----  8 ----
            let monterCarloData8: MonterCarloNew  = {
                let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 2048, score: 28668, moves: 516,zerosWeightMC: 2048)
                return  monterCarlo
            } ()
            // -----  9 ----
            let monterCarloData9: MonterCarloNew  = {
                let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 2048, score: 36168, moves: 516,zerosWeightMC: 2048)
                return  monterCarlo
            } ()
            // -----  10 ----
            let monterCarloData10: MonterCarloNew   = {
                let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 4096, score: 59765, moves: 516,zerosWeightMC: 2048)
                return  monterCarlo
            } ()
        
        // -----  11 ----
        let monterCarloData11: MonterCarloNew   = {
            let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 1024, score: 19765, moves: 516,zerosWeightMC: 2048)
            return  monterCarlo
        } ()
        
        // -----  12 ----
        let monterCarloData12: MonterCarloNew   = {
            let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 2048, score: 39765, moves: 516,zerosWeightMC: 2048)
            return  monterCarlo
        } ()
        
        // -----  13 ----
        let monterCarloData13: MonterCarloNew   = {
            let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 512, score: 9765, moves: 516,zerosWeightMC: 2048)
            return  monterCarlo
        } ()
        // -----  21 ----
        let monterCarloData21: MonterCarloNew   = {
            let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 1024, score: 19765, moves: 516,zerosWeightMC: 1024)
            return  monterCarlo
        } ()
        
        // -----  22 ----
        let monterCarloData22: MonterCarloNew   = {
            let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 2048, score: 39765, moves: 516,zerosWeightMC: 1024)
            return  monterCarlo
        } ()
        
        // -----  23 ----
        let monterCarloData23: MonterCarloNew   = {
            let monterCarlo = MonterCarloNew(algorithm:"Monte Carlo",time: Date.now,numberExperiments: 150, deep: 10, limitZeros: 4, maxTile: 512, score: 9765, moves: 516,zerosWeightMC: 1024)
            return  monterCarlo
        } ()
        return [monterCarloData1,monterCarloData2, monterCarloData3, monterCarloData4, monterCarloData5,monterCarloData6,monterCarloData7, monterCarloData8, monterCarloData9, monterCarloData10,monterCarloData11, monterCarloData12, monterCarloData13,monterCarloData21, monterCarloData22, monterCarloData23]
    }()
    
    static let treeSearches: [TreeSearch] = {
        // -----  1 ----
        let treeSearch1: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "Expectimax", time: Date.now, fourEstimate: false, zeroWeight: Constants.zerosWeight, zerosBeginning: Constants.zerosBeginning, maxTile: 2048, score: 35768, moves: 640)
            return treeSearch
        } ()
        // -----  2 ----
        let treeSearch2: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "Expectimax", time: Date.now, fourEstimate: false, zeroWeight: Constants.zerosWeight, zerosBeginning: Constants.zerosBeginning, maxTile: 2048, score: 48768, moves: 640)
            return treeSearch
        } ()
        // -----  3 ----
        let treeSearch3: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "Expectimax", time: Date.now, fourEstimate: false, zeroWeight: Constants.zerosWeight, zerosBeginning: Constants.zerosBeginning, maxTile: 2048, score: 35768, moves: 640)
            return treeSearch
        } ()
        // -----  4 ----
        let treeSearch4: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "Expectimax", time: Date.now, fourEstimate: false, zeroWeight: Constants.zerosWeight, zerosBeginning: Constants.zerosBeginning, maxTile: 4096, score: 35768, moves: 640)
            return treeSearch
        } ()
        
        // -----  5----
        let treeSearch5: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "Expectimax", time: Date.now, fourEstimate: false, zeroWeight: 2.7 /*Constants.zerosWeight*/, zerosBeginning: Constants.zerosBeginning, maxTile: 4096, score: 35768, moves: 640)
            return treeSearch
        } ()
        
        // -----  6----
        let treeSearch6: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "Expectimax", time: Date.now, fourEstimate: false, zeroWeight: 2.7 /*Constants.zerosWeight*/, zerosBeginning: Constants.zerosBeginning, maxTile: 2048, score: 35768, moves: 640)
            return treeSearch
        } ()
        // -----  7----
        let treeSearch7: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "Expectimax", time: Date.now, fourEstimate: false, zeroWeight: 2.7 /*Constants.zerosWeight*/, zerosBeginning: Constants.zerosBeginning, maxTile: 1024, score: 35768, moves: 640)
            return treeSearch
        } ()
        //-----------------------------
        
        // -----  8----
        let treeSearch8: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "ExpectiMAsync", time: Date.now, fourEstimate: false, zeroWeight: Constants.zerosWeight, zerosBeginning: Constants.zerosBeginning, maxTile: 2048, score: 35768, moves: 640)
            return treeSearch
        } ()
        // -----  9 ----
        let treeSearch9: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "ExpectiMAsync", time: Date.now, fourEstimate: false, zeroWeight: Constants.zerosWeight, zerosBeginning: Constants.zerosBeginning, maxTile: 4096, score: 35768, moves: 640)
            return treeSearch
        } ()
        
        // -----  10----
        let treeSearch10: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "ExpectiMAsync", time: Date.now, fourEstimate: false, zeroWeight: 2.7 /*Constants.zerosWeight*/, zerosBeginning: Constants.zerosBeginning, maxTile: 4096, score: 35768, moves: 640)
            return treeSearch
        } ()
        
        // -----  11----
        let treeSearch11: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "ExpectiMAsync", time: Date.now, fourEstimate: false, zeroWeight: 2.7 /*Constants.zerosWeight*/, zerosBeginning: Constants.zerosBeginning, maxTile: 2048, score: 35768, moves: 640)
            return treeSearch
        } ()
        // -----  12----
        let treeSearch12: TreeSearch = {
            let treeSearch = TreeSearch(algorithm: "ExpectiMAsync", time: Date.now, fourEstimate: false, zeroWeight: 2.7 /*Constants.zerosWeight*/, zerosBeginning: Constants.zerosBeginning, maxTile: 1024, score: 35768, moves: 640)
            return treeSearch
        } ()//-------------------------------
    
    // -----  13----
    let treeSearch13: TreeSearch = {
        let treeSearch = TreeSearch(algorithm: "ExpectiMAsync", time: Date.now, fourEstimate: false, zeroWeight: 2.7 , zerosBeginning: Constants.zerosBeginning, maxTile: 4096, score: 35768, moves: 640)
        return treeSearch
    } ()
    
    // -----  14----
    let treeSearch14: TreeSearch = {
        let treeSearch = TreeSearch(algorithm: "ExpectiMAsync", time: Date.now, fourEstimate: false, zeroWeight: 2.7 , zerosBeginning: Constants.zerosBeginning, maxTile: 2048, score: 35768, moves: 640)
        return treeSearch
    } ()
    
    // -----  15----
    let treeSearch15: TreeSearch = {
        let treeSearch = TreeSearch(algorithm: "ExpectiMAsync", time: Date.now, fourEstimate: false, zeroWeight: 2.7 , zerosBeginning: Constants.zerosBeginning, maxTile: 1024, score: 35768, moves: 640)
        return treeSearch
    } ()
    //-------------------------------
    return [treeSearch1, treeSearch2, treeSearch3,treeSearch4, treeSearch5, treeSearch6, treeSearch7,
            treeSearch8, treeSearch9, treeSearch10, treeSearch11, treeSearch12,
            treeSearch13, treeSearch14, treeSearch15]
}()
    
    static func monterCarlosInsert(context: ModelContext) {
        monterCarlos.forEach{context.insert($0)}
    }
    
    static func treeSearchesInsert(context: ModelContext) {
        treeSearches.forEach{context.insert($0)}
    }
}
