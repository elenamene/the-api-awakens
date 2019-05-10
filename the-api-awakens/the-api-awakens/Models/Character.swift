//
//  Character.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

enum Gender: String {
    case male = "Male"
    case female = "Female"
    case unknown = "Unknown"
}

struct Character: Resource {
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
}

extension Character {
    var category: Category {
        return .people
    }
}
