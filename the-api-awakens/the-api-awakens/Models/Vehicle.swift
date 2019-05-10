//
//  Vehicle.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct Vehicle: Resource, Transport {
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
}

extension Vehicle {
    var category: Category {
        return .vehicles
    }
}

