//
//  Starship.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

class Starship: Resource, Transport, Decodable, FilmAppearanceTrackable {
    var name: String
    var model: String
    var manufacturer: String
    var cost: String
    var length: String
    var maxAtmospheringSpeed: String
    var crew: String
    var passengers: String
    let mglt: String
    let hyperdriveRating: String
    let starshipClass: String
    var films: [String] = []
    
    // MARK: - Properties to fetch
    
    var filmsDownloaded = [Film]()
    var filmsDownloadState = DownloadState.notDownloaded
    
    // MARK: - Init
    
    init(name: String, model: String, manufacturer: String, cost: String, length: String, maxAtmospheringSpeed: String, crew: String, passengers: String, mglt: String, hyperdriveRating: String, starshipClass: String, films: [String]) {
        self.name = name
        self.model = model
        self.manufacturer = manufacturer
        self.cost = cost
        self.length = length
        self.maxAtmospheringSpeed = maxAtmospheringSpeed
        self.crew = crew
        self.passengers = passengers
        self.mglt = mglt
        self.hyperdriveRating = hyperdriveRating
        self.starshipClass = starshipClass
        self.films = films
    }
    
    // MARK: - Decodable
    
    private enum CodingKeys: String, CodingKey {
        case name
        case model
        case manufacturer
        case cost = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew
        case passengers
        case mglt = "MGLT"
        case hyperdriveRating = "hyperdrive_rating"
        case starshipClass = "starship_class"
        case films
    }
}

extension Starship {
    var category: Category {
        return .starships
    }
    
    static var endpoint: StarWarsEndpoint {
        return .starships
    }
}
