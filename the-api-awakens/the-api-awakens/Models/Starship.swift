//
//  Starship.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct Starship: Resource, Transport, Decodable {
    var name: String
    var model: String
    var manufacturer: String
    var cost: String
    var length: String
    var maxAtmospheringSpeed: String
    var crew: String
    var passengers: String
    let mglt: String
    let hyperdriveRating: String
    let starshipClass: String
    var films: [String] = []
    
    private enum CodingKeys: String, CodingKey {
        case name
        case model
        case manufacturer
        case cost = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew
        case passengers
        case mglt = "MGLT"
        case hyperdriveRating = "hyperdrive_rating"
        case starshipClass = "starship_class"
        case films
    }
}

extension Starship {
    var category: Category {
        return .starships
    }
    
    static var endpoint: StarWarsEndpoint {
        return .starships
    }
}
