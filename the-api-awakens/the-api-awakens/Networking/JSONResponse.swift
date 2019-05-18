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
    
    private enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
}

//extension JSONResponse {
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        self.count = try container.decode(Int.self, forKey: .count)
//        self.next = try container.decode(String?.self, forKey: .next)
//        self.previous = try container.decode(String?.self, forKey: .previous)
//        self.results = try container.decode([T].self, forKey: .results)
//    }
//}
