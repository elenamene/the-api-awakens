//
//  Resource.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 05/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

protocol Resource {
    var name: String { get } // name for the picker
    var category: Category { get }
}
