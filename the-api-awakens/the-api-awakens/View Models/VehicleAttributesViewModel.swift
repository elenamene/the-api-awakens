//
//  VehicleAttributesViewModel.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 08/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct VehicleAttributesViewModel: AttributesViewModel {
    var attributes: [Attribute]
}

extension VehicleAttributesViewModel {
    init(vehicle: Vehicle) {
        attributes = [
            Attribute(name: "Model", description: vehicle.model.capitalizeFirstLetter()),
            Attribute(name: "Manufacturer", description: vehicle.manufacturer.capitalizeFirstLetter()),
            Attribute(name: "Cost", description: "\(vehicle.cost) Galactic Credits"),
            Attribute(name: "Length", description: "\(vehicle.length) m"),
            Attribute(name: "Speed", description: "\(vehicle.maxAtmospheringSpeed) atmosphere"),
            Attribute(name: "Crew", description: String(vehicle.crew)),
            Attribute(name: "Passengers", description: String(vehicle.passengers)),
            Attribute(name: "Vehicle Class", description: vehicle.vehicleClass.capitalizeFirstLetter()),
            Attribute(name: "Film", description: "")
        ]
    }
}
