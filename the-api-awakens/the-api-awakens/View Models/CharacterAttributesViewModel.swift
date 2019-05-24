//
//  CharacterViewModel.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 08/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

// height: String // convert metric units (meters) to British units (inches)
// mass: String // convert metric units (meters) to British units (inches)

struct CharacterAttributesViewModel: AttributesViewModel {
    var attributes: [Attribute]
}

extension CharacterAttributesViewModel {
    init(character: Character) {
        attributes = [
            Attribute(name: "Height", description: "\(character.height) cm"),
            Attribute(name: "Mass", description: "\(character.mass) kg"),
            Attribute(name: "Hair Color", description: character.hairColor.capitalizeFirstLetter()),
            Attribute(name: "Skin Color", description: character.skinColor.capitalizeFirstLetter()),
            Attribute(name: "Eye Color", description: character.eyeColor.capitalizeFirstLetter()),
//            Attribute(name: "Gender", description: character.gender.rawValue.capitalizeFirstLetter()),
            Attribute(name: "Gender", description: "\(character.gender.capitalizeFirstLetter())"),
            Attribute(name: "Year Of Birth", description: character.yearOfBirth),
            Attribute(name: "Vehicles", description: character.vehicles.description),
            Attribute(name: "Starships", description: character.starships.description),
            Attribute(name: "Films", description: character.films.description),
        ]
    }
}
