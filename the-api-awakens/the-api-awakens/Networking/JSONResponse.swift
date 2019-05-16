//
//  SearchResult.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 14/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct JSONResponse<T: Decodable>: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [T]
}
