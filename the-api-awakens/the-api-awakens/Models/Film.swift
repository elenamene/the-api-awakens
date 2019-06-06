//
//  Film.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

class Film: Decodable, Resource, CharactersAppearanceTrackable, VehiclesAppearanceTrackable, StarshipsAppearanceTrackable {
    var name: String
    let episodeId: Int
    let director: String
    let producer: String
    let releaseDate: Date
    var characters: [String] = []
    var starships: [String] = []
    var vehicles: [String] = []
    
    // MARK: - Properties to fetch
    
    var charactersDownloaded = [Character]()
    var charactersDownloadState = DownloadState.notDownloaded
    var starshipsDownloaded = [Starship]()
    var starshipsDownloadState = DownloadState.notDownloaded
    var vehiclesDownloaded = [Vehicle]()
    var vehiclesDownloadState = DownloadState.notDownloaded
    
    // MARK: - Init
    
    init(name: String, episodeId: Int, director: String, producer: String, releaseDate: Date, characters: [String], starships: [String], vehicles: [String]) {
        self.name = name
        self.episodeId = episodeId
        self.director = director
        self.producer = producer
        self.releaseDate = releaseDate
        self.characters = characters
        self.starships = starships
        self.vehicles = vehicles
    }
    
    // MARK: - Decodable
    
    private enum CodingKeys: String, CodingKey {
        case name = "title"
        case episodeId = "episode_id"
        case director
        case producer
        case releaseDate = "release_date"
        case characters
        case starships
        case vehicles
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

