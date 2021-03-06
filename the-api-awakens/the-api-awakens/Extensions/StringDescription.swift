//
//  Double.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 30/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

// Formatters for view models

extension Measurement {
    func stringDescription() -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 1
        
        return formatter.string(from: self)
    }
}

extension Unit {
    func stringDescription() -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        
        return formatter.string(from: self)
    }
}

extension NSNumber {
    func stringDescription() -> String? {
        let formatter = NumberFormatter()
        
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        
        return formatter.string(from: self)
    }
}

extension Date {
    var stringDescription: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        
        return formatter.string(from: self)
    }
}
