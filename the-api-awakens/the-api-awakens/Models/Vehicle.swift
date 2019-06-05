//
//  Vehicle.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

class Vehicle: Resource, Transport, Decodable, FilmAppearanceTrackable {
    var name: String
    var model: String
    var manufacturer: String
    var cost: String
    var length: String
    var maxAtmospheringSpeed: String
    var crew: String
    var passengers: String
    let vehicleClass: String
    var films: [String] = []
    
    // MARK: - Properties to fetch
    
    var filmsDownloaded = [Film]()
    var filmsDownloadState = DownloadState.notDownloaded
    
    // MARK: - Init
    
    init(name: String, model: String, manufacturer: String, cost: String, length: String, maxAtmospheringSpeed: String, crew: String, passengers: String, vehicleClass: String, films: [String]) {
        self.name = name
        self.model = model
        self.manufacturer = manufacturer
        self.cost = cost
        self.length = length
        self.maxAtmospheringSpeed = maxAtmospheringSpeed
        self.crew = crew
        self.passengers = passengers
        self.vehicleClass = vehicleClass
        self.films = films
    }
    
    // MARK: - Decodable
    
    private enum CodingKeys: String, CodingKey {
        case name
        case model
        case manufacturer
        case cost = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew
        case passengers
        case vehicleClass = "vehicle_class"
        case films
    }
}

extension Vehicle {
    var category: Category {
        return .vehicles
    }
    
    static var endpoint: StarWarsEndpoint {
        return .vehicles
    }
}
