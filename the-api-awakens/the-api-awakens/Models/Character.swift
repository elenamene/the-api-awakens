//
//  Character.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

enum Gender: String, Decodable {
    case male = "Male"
    case female = "Female"
    case unknown = "Unknown"
    
    private enum CodingKeys: String, CodingKey {
        case male
        case female
        case unknown // -> "n/a"
    }
}

struct Character: Resource, Decodable {
    let name: String
    let height: Int
    let mass: Int
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let gender: Gender
    let yearOfBirth: String
    var vehicles: [Vehicle] = []
    var starships: [Starship] = []
    var films: [Film] = []
    
    private enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hairColor
        case skinColor
        case eyeColor
        case gender
        case yearOfBirth = "birth_year"
        case vehicles
        case starships
        case films
    }
}

extension Character {
    var category: Category {
        return .people
    }
}
