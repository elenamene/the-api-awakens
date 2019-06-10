//
//  FilmViewModel.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 05/06/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct FilmViewModel: AttributesTableViewModel {
    var attributes: [AttributeViewModel]
}

extension FilmViewModel {
    init(film: Film) {
        var charactersDescription: String {
            if film.characters.isEmpty {
                return "\(film.name) does not have any character."
            } else {
                let charactersArray = film.charactersDownloaded.map { $0.name }
                return charactersArray.joined(separator: ", ")
            }
        }
        
        var vehiclesDescription: String {
            if film.vehicles.isEmpty {
                return "\(film.name) does not have any vehicle."
            } else {
                let vehiclesArray = film.vehiclesDownloaded.map { $0.name }
                return vehiclesArray.joined(separator: ", ")
            }
        }
        
        var starshipsDescription: String {
            if film.starships.isEmpty {
                return "\(film.name) does not have any starship."
            } else {
                let starshipsArray = film.starshipsDownloaded.map { $0.name }
                return starshipsArray.joined(separator: ", ")
            }
        }
        
        attributes = [
            Attribute(name: "Episode N.", description: "\(film.episodeId)"),
            Attribute(name: "Director", description: film.director.capitalizeFirstLetter()),
            Attribute(name: "Producer", description: film.producer.capitalizeFirstLetter()),
            Attribute(name: "Release Date", description: film.releaseDate.stringDescription),
            Attribute(name: "Characters", description: charactersDescription),
            Attribute(name: "Vehicles", description: vehiclesDescription),
            Attribute(name: "Starships", description: starshipsDescription)
        ]
    }
}
