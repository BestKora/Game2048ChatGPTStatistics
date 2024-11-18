//
//  MonteCarloNew.swift
//  My2048New
//
//  Created by Tatiana Kornilova on 14.04.2024.
//

import Foundation
import SwiftData

// MARK: - @Model MonteCarloNew

@Model final class MonterCarloNew: Codable {

    var algorithm: String = "Monte Carlo"
    var time: Date = Date.now
    var numberSimulations: Int = 100
    var deep: Int = 10
    var limitZeros: Int = 4
    var maxTile: Int = 2
    var score: Int = 0
    var moves: Int = 0
    var zerosWeightMC : Int = 16384
    
    init(algorithm: String,time: Date, numberExperiments: Int, deep: Int, limitZeros: Int, maxTile: Int, score: Int, moves: Int, zerosWeightMC : Int) {
        self.algorithm = algorithm
        self.time = time
        self.numberSimulations = numberExperiments
        self.deep = deep
        self.limitZeros = limitZeros
        self.maxTile = maxTile
        self.score = score
        self.moves = moves
        self.zerosWeightMC = zerosWeightMC
    }
    
    enum CodingKeys: String, CodingKey {
            case algorithm
            case time
            case numberExperiments
            case deep
            case limitZeros
            case maxTile
            case score
            case moves
            case zerosWeightMC
        }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.algorithm = try container.decode(String.self, forKey: .algorithm)
        self.time = try container.decode(Date.self, forKey: .time)
        self.numberSimulations = try container.decode(Int.self, forKey: .numberExperiments)
        self.deep = try container.decode(Int.self, forKey: .deep)
        self.limitZeros = try container.decode(Int.self, forKey: .limitZeros)
        self.maxTile = try container.decode(Int.self, forKey: .maxTile)
        self.score = try container.decode(Int.self, forKey: .score)
        self.moves = try container.decode(Int.self, forKey: .moves)
        self.zerosWeightMC = try container.decode(Int.self, forKey: .zerosWeightMC)
    }
    
    func encode(to encoder: Encoder) throws {
      // TODO: Handle encoding if you need to here
        var container = encoder.container(keyedBy: CodingKeys.self)
       
        try container.encode(algorithm, forKey: .algorithm)
        try container.encode(time, forKey: .time)
        try container.encode(numberSimulations, forKey: .numberExperiments)
        try container.encode(deep, forKey: .deep)
        try container.encode(limitZeros, forKey: .limitZeros)
        try container.encode(maxTile, forKey: .maxTile)
        try container.encode(score, forKey: .score)
        try container.encode(moves, forKey: .moves)
        try container.encode(zerosWeightMC, forKey: .zerosWeightMC)
    }
}
