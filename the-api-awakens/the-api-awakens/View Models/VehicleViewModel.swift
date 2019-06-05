//
//  VehicleAttributesViewModel.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 08/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct VehicleViewModel: AttributesTableViewModel {
    var attributes: [AttributeViewModel]
}

extension VehicleViewModel {
    init(vehicle: Vehicle) {
        var filmsDescription: String {
            if vehicle.films.isEmpty {
                return "\(vehicle.name) has not been in any film."
            } else {
                let filmsArray = vehicle.filmsDownloaded.map { $0.name }
                return filmsArray.joined(separator: ", ")
            }
        }
        
        attributes = [
            Attribute(name: "Model", description: vehicle.model.capitalizeFirstLetter()),
            Attribute(name: "Manufacturer", description: vehicle.manufacturer.capitalizeFirstLetter()),
            CurrencyConvertibleAttribute(value: vehicle.cost),
            MeasureConvertibleAttribute(name: "Length", value: vehicle.length, units: [UnitLength.meters, UnitLength.feet]),
            Attribute(name: "Speed", description: "\(vehicle.maxAtmospheringSpeed) atmosphere"),
            Attribute(name: "Crew", description: String(vehicle.crew)),
            Attribute(name: "Passengers", description: String(vehicle.passengers)),
            Attribute(name: "Vehicle Class", description: vehicle.vehicleClass.capitalizeFirstLetter()),
            Attribute(name: "Films", description: filmsDescription)
        ]
    }
}
