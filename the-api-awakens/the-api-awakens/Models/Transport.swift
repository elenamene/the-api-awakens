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
    var cost: String { get }
    var length: String { get }
    var maxAtmospheringSpeed: String { get }
    var crew: String { get }
    var passengers: String { get }
}
