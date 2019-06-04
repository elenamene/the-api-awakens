//
//  Character.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

enum DownloadState {
    case notDownloaded
    case downloaded
    case failed
}

class Character: Resource, Decodable {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let gender: String
    let yearOfBirth: String
    var vehicles: [String] = []
    var starships: [String] = []
    var films: [String] = []
    
    // MARK: - Properties to fetch
    
    var vehiclesDownloaded = [Vehicle]()
    var starshipsDownloaded = [Starship]()
    var filmsDownloaded = [Film]()
    
    var vehiclesDownloadState = DownloadState.notDownloaded
    var starshipsDownloadState = DownloadState.notDownloaded
    var filmsDownloadState = DownloadState.notDownloaded
    
    // MARK: - Init
    
    init(name: String, height: String, mass: String, hairColor: String, skinColor: String, eyeColor: String, gender: String, yearOfBirth: String) {
        self.name = name
        self.height = height
        self.mass = mass
        self.hairColor = hairColor
        self.skinColor = skinColor
        self.eyeColor = eyeColor
        self.gender = gender
        self.yearOfBirth = yearOfBirth
    }
    
    // MARK: - Decodable
    
    private enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case gender
        case yearOfBirth = "birth_year"
        case vehicles
        case starships
        case films
    }
}

extension Character {
    var category: Category {
        return .people
    }
    
    static var endpoint: StarWarsEndpoint {
        return .people
    }
}

