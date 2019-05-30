//
//  AttributeViewModel.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 10/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol AttributeViewModel {
    var name: String { get }
    var description: String { get }
}

protocol Convertible {
    var conversionControlLabels: [String] { get }
}

// MARK: - View Models

/// View Model used to configure a basic AttributeCell
struct Attribute: AttributeViewModel {
    var name: String
    var description: String
}

/// View Model used to configure an AttributeCell that supports measure conversion
struct MeasurableAttribute: AttributeViewModel, Convertible {
    var name: String
    var description: String
    var convertedDescription: String
    var conversionControlLabels: [String]

    init(name: String, value: String, units: [Dimension]) {
        self.name = name
        
        guard let numberValue = Double(value) else {
            print("Cannot convert value: \(value) into a Measurement")
            fatalError()
        }
        
        let measure = Measurement(value: numberValue, unit: units[0])
        let convertedMeasure = measure.converted(to: units[1])
        
        self.description = measure.stringDescription()
        self.convertedDescription = convertedMeasure.stringDescription()
        self.conversionControlLabels = units.map { unit in unit.stringDescription() }
    }
}

/// View Model used to configure an AttributeCell that supports currency conversion
struct CurrencyConvertibleAttribute: AttributeViewModel, Convertible {
    typealias ExchangeRate = Double
    
    var name: String
    var description: String
    var conversionControlLabels: [String]
    
    init(name: String = "Cost", value: String, currencies: [String] = ["G Credit", "USD"]) {
        self.name = name
        self.description = "\(value)"
        self.conversionControlLabels = currencies
    }
    
    func convertedValue(with rate: ExchangeRate) -> String? {
        guard let value = Double(description) else { return nil }
        let convertedValue = NSNumber(value: value * rate)
        
        return convertedValue.stringDescription()
    }
}

/// View Model used to populate a Table View with an array of attributes
protocol AttributesTableViewModel {
    var attributes: [AttributeViewModel] { get }
}
