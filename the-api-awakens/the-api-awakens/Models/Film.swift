//
//  Film.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct Film: Decodable, Resource {
    var name: String
    let episodeId: Int
    let director: String
    let producer: String
    let releaseDate: String
//    var characters: [Character] = []
    
    private enum CodingKeys: String, CodingKey {
        case name = "title"
        case episodeId = "episode_id"
        case director
        case producer
        case releaseDate = "release_date"
    }
}

extension Film {
    var category: Category {
        return .films
    }
    
    static var endpoint: StarWarsEndpoint {
        return .films
    }
    
    
}

