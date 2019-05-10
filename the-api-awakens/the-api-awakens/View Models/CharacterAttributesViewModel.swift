//
//  CharacterViewModel.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 08/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

// let height: String // convert metric units (meters) to British units (inches)
// let mass: String // convert metric units (meters) to British units (inches)

struct CharacterAttributesViewModel: AttributesViewModel {
    var attributes: [Attribute]
}

extension CharacterAttributesViewModel {
    init(character: Character) {
        attributes = [
//            Attribute(name: "Name", description: character.name),
            Attribute(name: "Height", description: "\(character.height) cm"),
            Attribute(name: "Mass", description: "\(character.mass) kg"),
            Attribute(name: "Hair Color", description: character.hairColor.capitalizeFirstLetter()),
            Attribute(name: "Skin Color", description: character.skinColor.capitalizeFirstLetter()),
            Attribute(name: "Eye Color", description: character.eyeColor.capitalizeFirstLetter()),
            Attribute(name: "Gender", description: character.gender.rawValue.capitalizeFirstLetter()),
            Attribute(name: "Year Of Birth", description: character.yearOfBirth),
            Attribute(name: "Vehicles", description: ""),
            Attribute(name: "Starships", description: ""),
            Attribute(name: "Films", description: ""),
        ]
    }
}

//struct CharacterAttributesViewModel {
//    let name: String
//    let height: String // convert metric units (meters) to British units (inches)
//    let mass: String // convert metric units (meters) to British units (inches)
//    let hairColor: String
//    let skinColor: String
//    let eyeColor: String
//    let gender: String
//    let yearOfBirth: String
//    var vehicles: String
//    var starships: String
//    var films: String
//}
//
//extension CharacterAttributesViewModel {
//    init(character: Character) {
//        self.name = character.name
//        self.height = "\(character.height) cm"
//        self.mass = "\(character.mass) kg"
//        self.hairColor = character.hairColor
//        self.skinColor = character.skinColor
//        self.eyeColor = character.eyeColor
//        self.gender = character.gender.rawValue
//        self.yearOfBirth = character.yearOfBirth
//        self.vehicles = ""
//        self.starships = ""
//        self.films = ""
//    }
//
//    var attributes: [Attribute] {
//        return [
//            Attribute(name: "Name", value: self.name),
//            Attribute(name: "Height", value: self.height),
//            Attribute(name: "Mass", value: self.mass),
//            Attribute(name: "Hair Color", value: self.hairColor),
//            Attribute(name: "Skin Color", value: self.skinColor),
//            Attribute(name: "Eye Color", value: self.eyeColor),
//            Attribute(name: "Gender", value: self.gender),
//            Attribute(name: "Year Of Birth", value: self.yearOfBirth),
//            Attribute(name: "Vehicles", value: self.vehicles),
//            Attribute(name: "Starships", value: self.starships),
//            Attribute(name: "Films", value: self.films),
//        ]
//
//    }
//}
