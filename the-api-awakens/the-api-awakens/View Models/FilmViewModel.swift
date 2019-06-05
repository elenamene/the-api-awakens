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
        attributes = [
            Attribute(name: "Episode N.", description: "\(film.episodeId)"),
            Attribute(name: "Director", description: film.director.capitalizeFirstLetter()),
            Attribute(name: "Producer", description: film.producer.capitalizeFirstLetter()),
            Attribute(name: "Release Date", description: film.releaseDate)
        ]
    }
}
