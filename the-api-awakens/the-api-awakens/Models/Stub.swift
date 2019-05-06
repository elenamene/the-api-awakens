//
//  Stub.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct Stub {
    static var characters: [Character] {
        let luke = Character(name: "Luke Skywalker", height: 172, mass: 77, hairColor: "blond", skinColor: "fair", eyeColor: "blue", gender: .male, yearOfBirth: "19BBY", vehicles: [], starships: [], films: [])
        let darth = Character(name: "Darth Vader", height: 202, mass: 306, hairColor: "none", skinColor: "white", eyeColor: "yellow", gender: .male, yearOfBirth: "41.9BBY", vehicles: [], starships: [], films: [])
       
        return [luke, darth]
    }
    
    static var vehicles: [Vehicle] {
        let snowspeeder = Vehicle(name: "Snowspeeder", model: "t-47 airspeeder", manufacturer: "Incom corporation", cost: nil, length: 4.5, maxAtmospheringSpeed: 650, crew: 2, passengers: 0, vehicleClass: "airspeeder", films: [])
        let x34 = Vehicle(name: "X-34 landspeeder", model: "X-34 landspeeder", manufacturer: "SoroSuub Corporation", cost: 10550, length: 3.4, maxAtmospheringSpeed: 250, crew: 1, passengers: 1, vehicleClass: "repulsorcraft", films: [])
        
        return [snowspeeder, x34]
    }
    
    static var starships: [Starship] {
        let millenniumFalcon = Starship(name: "Millennium Falcon", model: "YT-1300 light freighter", manufacturer: "Corellian Engineering Corporation", cost: 100000, length: 34.37, maxAtmospheringSpeed: 1050, crew: 4, passengers: 6, mglt: 75, hyperdriveRating: 0.5, starshipClass: "Light freighter", films: [])
        
        let executor = Starship(name: "Executor", model: "Executor-class star dreadnought", manufacturer: "Kuat Drive Yards, Fondor Shipyards", cost: 1143350000, length: 19000, maxAtmospheringSpeed: nil, crew: 279144, passengers: 38000, mglt: 40, hyperdriveRating: 2.0, starshipClass: "Star dreadnought", films: [])
        
        return [millenniumFalcon, executor]
    }
}
