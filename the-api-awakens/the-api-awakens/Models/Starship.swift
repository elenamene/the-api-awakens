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
    
    
}

extension Starship {
    var category: Category {
        return .starships
    }
}

extension Starship {
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
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.model = try container.decode(String.self, forKey: .model)
//        self.manufacturer = try container.decode(String.self, forKey: .manufacturer)
//        self.cost = try container.decode(String.self, forKey: .cost)
//        self.length = try container.decode(String.self, forKey: .length)
//        self.maxAtmospheringSpeed = try container.decode(String.self, forKey: .maxAtmospheringSpeed)
//        self.crew = try container.decode(String.self, forKey: .crew)
//        self.passengers = try container.decode(String.self, forKey: .passengers)
//        self.mglt = try container.decode(String.self, forKey: .mglt)
//        self.hyperdriveRating = try container.decode(String.self, forKey: .hyperdriveRating)
//        self.starshipClass = try container.decode(String.self, forKey: .starshipClass)
//        self.films = try container.decode([String].self, forKey: .films)
//    }
}
