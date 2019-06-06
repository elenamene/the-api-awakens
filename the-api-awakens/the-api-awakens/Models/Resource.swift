//
//  Resource.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 05/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

// MARK: - Protocol Resource

/// A general resource of the Star Wars API
protocol Resource {
    var name: String { get } // name for the picker
    var category: Category { get }
    static var endpoint: StarWarsEndpoint { get }
}

// MARK: - Protocols Inheriting from Resource

/// A Resource that can track the films it has appeared in
/// For example all the films a character has appeared in or a starship
protocol FilmAppearanceTrackable: Resource {
    var films: [String] { get }
    var filmsDownloaded: [Film] { get set }
    var filmsDownloadState: DownloadState { get set }
    
    // add fetch func?
}

/// A Resource that can track vehicles
/// For example all the vehicles a character has piloted or that has appeared in a film
protocol VehiclesAppearanceTrackable: Resource {
    var vehicles: [String] { get }
    var vehiclesDownloaded: [Vehicle] { get set }
    var vehiclesDownloadState: DownloadState { get set }
    
    // add fetch func?
}

/// A Resource that can track starships
/// For example all the starships a character has piloted or that has appeared in a film
protocol StarshipsAppearanceTrackable: Resource {
    var starships: [String] { get }
    var starshipsDownloaded: [Starship] { get set }
    var starshipsDownloadState: DownloadState { get set }
    
    // add fetch func?
}

/// A Resource that can track characters
/// For example all the characters that have piloted a starship
protocol CharactersAppearanceTrackable: Resource {
    var characters: [String] { get }
    var charactersDownloaded: [Character] { get set }
    var charactersDownloadState: DownloadState { get set }
    
    // add fetch func?
}

