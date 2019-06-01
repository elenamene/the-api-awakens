//
//  CharacterViewModel.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 08/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct CharacterViewModel: AttributesTableViewModel {
    var attributes: [AttributeViewModel]
}

extension CharacterViewModel {
    init(character: Character) {
        attributes = [
            MeasureConvertibleAttribute(name: "Height", value: character.height, units: [UnitLength.centimeters, UnitLength.inches]),
            MeasureConvertibleAttribute(name: "Mass", value: character.mass, units: [UnitMass.kilograms, UnitMass.pounds]),
            Attribute(name: "Hair Color", description: character.hairColor.capitalizeFirstLetter()),
            Attribute(name: "Skin Color", description: character.skinColor.capitalizeFirstLetter()),
            Attribute(name: "Eye Color", description: character.eyeColor.capitalizeFirstLetter()),
            Attribute(name: "Gender", description: "\(character.gender.capitalizeFirstLetter())"),
            Attribute(name: "Year Of Birth", description: character.yearOfBirth),
            Attribute(name: "Vehicles", description: character.vehicles.description),
            Attribute(name: "Starships", description: character.starships.description),
            Attribute(name: "Films", description: character.films.description),
        ]
    }
}
