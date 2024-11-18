//
//  Constants.swift
//  My2048
//
//  Created by Tatiana Kornilova on 01.01.2023.
//

import SwiftUI

struct Constants {
    
    // -------Monte Carlo -----
    static var numberSimilations = 180 // 150 200
    static var deep = 20  // 10 15
    static var limitZeros = 4 //6
    static var zerosWeightMC = 16384 // 1024 2048 4096 8192 16384 zeros weight
    
    // -------Tree search-----
    static var zerosWeight = 11.7 // 2.7 5.7
    static var zerosBeginning = 4  //  3 zeros beginning
    
    enum DefaultConstants {
       static var numberSimilations = 180 // 100 95
       static var deep = 20  //10 15
       static var limitZeros = 4 //6
       static var zerosWeightMC = 16384 // 1024 2048 4096 8192 16384 zeros weight
        
        // -------Tree search-----
        static var zerosWeight = 11.7  // 2014 4096 8192 zeros weight
        static var zerosBeginning = 4  //  3 zeros beginning
    }
    
    static func reset() {
        numberSimilations = DefaultConstants.numberSimilations
        deep = DefaultConstants.deep
        limitZeros = DefaultConstants.limitZeros
        zerosWeightMC = DefaultConstants.zerosWeightMC
        
        zerosWeight = DefaultConstants.zerosWeight
        zerosBeginning = DefaultConstants.zerosBeginning
    }
}

struct Settings {
    
    // -------Monte Carlo -----
    var numberSimulations = 180 // 100 150
    var deep = 20  //10n15 20
    var limitZeros = 4 //6
    var zerosWeightMC = 16384
    
    // -------Tree search-----
    var zerosWeight = 11.7  // 1024 2014 4096 8192 zeros weight
    var zerosBeginning = 4  //  3 zeros beginning
    
    func updateConstants() {
        
      Constants.numberSimilations =  numberSimulations
      Constants.deep =  deep
      Constants.limitZeros = limitZeros
      Constants.zerosWeightMC = zerosWeightMC
        
      Constants.zerosWeight = zerosWeight
      Constants.zerosBeginning =  zerosBeginning
        
    }
    
   mutating func reset() {
       numberSimulations = Constants.DefaultConstants.numberSimilations
       deep = Constants.DefaultConstants.deep
       limitZeros = Constants.DefaultConstants.limitZeros
       zerosWeightMC  = Constants.DefaultConstants.zerosWeightMC
        
       zerosWeight = Constants.DefaultConstants.zerosWeight
       zerosBeginning = Constants.DefaultConstants.zerosBeginning
    }
}

