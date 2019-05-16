//
//  Vehicle.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct Vehicle: Resource, Transport, Decodable {
    var name: String
    var model: String
    var manufacturer: String
    var cost: Int
    var length: Double
    var maxAtmospheringSpeed: Int
    var crew: Int
    var passengers: Int
    let vehicleClass: String
    var films: [Film] = []
    
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
}

