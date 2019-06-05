//
//  Resource.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 05/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

/// A general resource of the Star Wars API
protocol Resource {
    var name: String { get } // name for the picker
    var category: Category { get }
    static var endpoint: StarWarsEndpoint { get }
}

/// A Resource that can track the films it has appeared in
protocol FilmAppearanceTrackable {
    var films: [String] { get }
    var filmsDownloaded: [Film] { get set }
    var filmsDownloadState: DownloadState { get set }
}
