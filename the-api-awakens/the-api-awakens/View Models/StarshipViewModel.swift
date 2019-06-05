//
//  StarshipAttributesViewModel.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 08/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct StarshipViewModel: AttributesTableViewModel {
    var attributes: [AttributeViewModel]
}

extension StarshipViewModel {
    init(starship: Starship) {
        var filmsDescription: String {
            if starship.films.isEmpty {
                return "\(starship.name) does not appear in any film."
            } else {
                let filmsArray = starship.filmsDownloaded.map { $0.name }
                print(filmsArray.joined(separator: ", "))
                return filmsArray.joined(separator: ", ")
            }
        }
        
        attributes = [
            Attribute(name: "Model", description: starship.model.capitalizeFirstLetter()),
            Attribute(name: "Manufacturer", description: starship.manufacturer.capitalizeFirstLetter()),
            CurrencyConvertibleAttribute(value: starship.cost),
            MeasureConvertibleAttribute(name: "Length", value: starship.length, units: [UnitLength.meters, UnitLength.feet]),
            Attribute(name: "Speed", description: "\(starship.maxAtmospheringSpeed) atmosphere"),
            Attribute(name: "Crew", description: String(starship.crew)),
            Attribute(name: "Passengers", description: String(starship.passengers)),
            Attribute(name: "Speed", description: String(starship.mglt) + " MGLT"),
            Attribute(name: "Hyperdrive Rating", description: String(starship.hyperdriveRating)),
            Attribute(name: "Starship Class", description: starship.starshipClass.capitalizeFirstLetter()),
            Attribute(name: "Films", description: filmsDescription),
        ]
    }
}
