//
//  AttributeViewModel.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 10/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct Attribute {
    let name: String
    let description: String
}

protocol AttributesViewModel {
    var attributes: [Attribute] { get }
}
