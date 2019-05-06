//
//  Transport.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

protocol Transport {
    var name: String { get }
    var model: String { get }
    var manufacturer: String { get }
    var cost: Int? { get }
    var length: Double { get }
    var maxAtmospheringSpeed: Int? { get }
    var crew: Int { get }
    var passengers: Int { get }
}
