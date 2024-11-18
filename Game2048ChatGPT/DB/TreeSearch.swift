//
//  TreeSearch.swift
//  My2048New
//
//  Created by Tatiana Kornilova on 12.03.2024.
//

import Foundation
import SwiftData

// MARK: - @Model TreeSearch

@Model final class TreeSearch: Codable {

    var algorithm: String
    var time: Date = Date.now
    var fourEstimate: Bool = false
    var zeroWeight: Double = 5.7
    var zerosBeginning: Int = 4
    var maxTile: Int = 2
    var score: Int = 0
    var moves: Int = 0
    
    init(algorithm: String, time: Date, fourEstimate: Bool, zeroWeight: Double, zerosBeginning: Int, maxTile: Int, score: Int, moves: Int) {
        self.algorithm = algorithm
        self.time = time
        self.fourEstimate = fourEstimate
        self.zeroWeight = zeroWeight
        self.zerosBeginning = zerosBeginning
        self.maxTile = maxTile
        self.score = score
        self.moves = moves
    }
    
    enum CodingKeys: String, CodingKey {
            case algorithm
            case time
            case fourEstimate
            case zeroWeight
            case zerosBeginning
            case maxTile
            case score
            case moves
        }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.algorithm = try container.decode(String.self, forKey: .algorithm)
        self.time = try container.decode(Date.self, forKey: .time)
        self.fourEstimate = try container.decode(Bool.self, forKey: .fourEstimate)
        self.zeroWeight = try container.decode(Double.self, forKey: .zeroWeight)
        self.zerosBeginning = try container.decode(Int.self, forKey: .zerosBeginning)
        self.maxTile = try container.decode(Int.self, forKey: .maxTile)
        self.score = try container.decode(Int.self, forKey: .score)
        self.moves = try container.decode(Int.self, forKey: .moves)
    }
    
    func encode(to encoder: Encoder) throws {
      // TODO: Handle encoding if you need to here
        var container = encoder.container(keyedBy: CodingKeys.self)
       
        try container.encode(algorithm, forKey: .algorithm)
        try container.encode(time, forKey: .time)
        try container.encode(fourEstimate, forKey: .fourEstimate)
        try container.encode(zeroWeight, forKey: .zeroWeight)
        try container.encode(zerosBeginning, forKey: .zerosBeginning)
        try container.encode(maxTile, forKey: .maxTile)
        try container.encode(score, forKey: .score)
        try container.encode(moves, forKey: .moves)
    }
}
