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
        var vehiclesDescription: String {
            if character.vehicles.isEmpty {
                return "\(character.name) has not piloted any vehicle."
            } else {
                let vehiclesArray = character.vehiclesDownloaded.map { $0.name }
                return vehiclesArray.joined(separator: ", ")
            }
        }
        
        var starshipsDescription: String {
            if character.starships.isEmpty {
                return "\(character.name) has not piloted any starship."
            } else {
                let starshipsArray = character.starshipsDownloaded.map { $0.name }
                return starshipsArray.joined(separator: ", ")
            }
        }
        
        var filmsDescription: String {
            if character.films.isEmpty {
                return "\(character.name) has not been in any film."
            } else {
                let filmsArray = character.filmsDownloaded.map { $0.name }
                return filmsArray.joined(separator: ", ")
            }
        }
        
        attributes = [
            MeasureConvertibleAttribute(name: "Height", value: character.height, units: [UnitLength.centimeters, UnitLength.inches]),
            MeasureConvertibleAttribute(name: "Mass", value: character.mass, units: [UnitMass.kilograms, UnitMass.pounds]),
            Attribute(name: "Hair Color", description: character.hairColor.capitalizeFirstLetter()),
            Attribute(name: "Skin Color", description: character.skinColor.capitalizeFirstLetter()),
            Attribute(name: "Eye Color", description: character.eyeColor.capitalizeFirstLetter()),
            Attribute(name: "Gender", description: "\(character.gender.capitalizeFirstLetter())"),
            Attribute(name: "Year Of Birth", description: character.yearOfBirth),
            Attribute(name: "Vehicles", description: vehiclesDescription),
            Attribute(name: "Starships", description: starshipsDescription),
            Attribute(name: "Films", description: filmsDescription),
        ]
    }
}

