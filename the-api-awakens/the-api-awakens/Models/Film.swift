//
//  Film.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct Film: Decodable {
    let title: String
    let episodeId: Int
//    let director: String
//    let producer: String
//    let releaseDate: Date
//    var characters: [Character] = []
    
    private enum CodingKeys: String, CodingKey {
        case title
        case episodeId = "episode_id"
    }
}

