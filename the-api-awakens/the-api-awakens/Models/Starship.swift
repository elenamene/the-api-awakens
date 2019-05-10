//
//  Starship.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct Starship: Resource, Transport {
    var name: String
    var model: String
    var manufacturer: String
    var cost: Int
    var length: Double
    var maxAtmospheringSpeed: Int
    var crew: Int
    var passengers: Int
    let mglt: Int
    let hyperdriveRating: Double
    let starshipClass: String
    var films: [Film] = []
}

extension Starship {
    var category: Category {
        return .starships
    }
}
