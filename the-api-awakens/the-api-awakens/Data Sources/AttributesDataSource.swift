//
//  ResultsListDataSource.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class AttributesDataSource: NSObject, UITableViewDataSource {
    
    private var resource: Resource {
        didSet {
            switch resource.category {
            case .people: tableViewViewModel = CharacterViewModel(character: resource as! Character)
            case .starships: tableViewViewModel = StarshipViewModel(starship: resource as! Starship)
            case .vehicles: tableViewViewModel = VehicleViewModel(vehicle: resource as! Vehicle)
            case .films: tableViewViewModel = FilmViewModel(film: resource as! Film)
            }
        }
    }
    
    private var tableViewViewModel: AttributesTableViewModel?
    private let tableView: UITableView
    
    init(from resource: Resource, tableView: UITableView) {
        self.resource = resource
        self.tableView = tableView
        
        super.init()
    }
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewViewModel!.attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath) as! AttributeCell
        
        // Assign viewModel to cell
        cell.viewModel = tableViewViewModel!.attributes[indexPath.row]
        
        // Check if cell needs to download the vehicles names
        switch cell.viewModel?.name {
        case "Vehicles": fetchVehicleNamesFor(cell, at: indexPath)
        case "Starships": fetchStarshipNamesFor(cell, at: indexPath)
        case "Films": fetchFilmNamesFor(cell, at: indexPath)
        case "Characters": fetchCharactersNamesFor(cell, at: indexPath)
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Info"
    }
    
    // MARK: - Helper Methods
    
    func update(with resource: Resource) {
        self.resource = resource
    }
    
    func fetchVehicleNamesFor(_ cell: AttributeCell, at indexPath: IndexPath) {
        if var resource = resource as? VehiclesAppearanceTrackable, resource.vehiclesDownloadState == .notDownloaded {
            let urls = resource.vehicles.map { URL(string: $0)! }
            
            StarWarsAPIClient<Vehicle>.fetch(urls) { result in
                switch result {
                case .success(let vehicles):
                    // Assign the vehicles back to the resource
                    resource.vehiclesDownloaded = vehicles
                    resource.vehiclesDownloadState = .downloaded
                    
                    // Update cell viewModel with character
                    self.resource = resource
                    cell.viewModel = self.tableViewViewModel?.attributes[indexPath.row]
                    
                    // Reload cell
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                case .failure(let error):
                    resource.vehiclesDownloadState = .failed
                    print(error)
                }
            }
        }
    }
    
    func fetchStarshipNamesFor(_ cell: AttributeCell, at indexPath: IndexPath) {
        if var resource = resource as? StarshipsAppearanceTrackable, resource.starshipsDownloadState == .notDownloaded {
            let urls = resource.starships.map { URL(string: $0)! }
            print("Fetching \(urls.count) urls")
            
            StarWarsAPIClient<Starship>.fetch(urls) { result in
                switch result {
                case .success(let starships):
                    // Assign the vehicles back to the resource
                    resource.starshipsDownloaded = starships
                    resource.starshipsDownloadState = .downloaded
                    
                    // Update cell viewModel with character
                    self.resource = resource
                    cell.viewModel = self.tableViewViewModel?.attributes[indexPath.row]
                    
                    // Reload cell
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                case .failure(let error):
                    resource.starshipsDownloadState = .failed
                    print(error)
                }
            }
        }
    }
    
    func fetchFilmNamesFor(_ cell: AttributeCell, at indexPath: IndexPath) {
        if var resource = resource as? FilmAppearanceTrackable, resource.filmsDownloadState == .notDownloaded {
            let urls = resource.films.map { URL(string: $0)! }

            StarWarsAPIClient<Film>.fetch(urls) { result in
                switch result {
                case .success(let films):
                    // Assign the vehicles back to the resource
                    resource.filmsDownloaded = films
                    resource.filmsDownloadState = .downloaded
                    
                    // Update cell viewModel with character
                    self.resource = resource
                    cell.viewModel = self.tableViewViewModel?.attributes[indexPath.row]
                    
                    // Reload cell
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                case .failure(let error):
                    resource.filmsDownloadState = .failed
                    print(error)
                }
            }
        }
    }
    
    func fetchCharactersNamesFor(_ cell: AttributeCell, at indexPath: IndexPath) {
        if var resource = resource as? CharactersAppearanceTrackable, resource.charactersDownloadState == .notDownloaded {
            let urls = resource.characters.map { URL(string: $0)! }
            
            StarWarsAPIClient<Character>.fetch(urls) { result in
                switch result {
                case .success(let characters):
                    // Assign the characters back to the resource
                    resource.charactersDownloaded = characters
                    resource.charactersDownloadState = .downloaded
                    
                    // Update cell viewModel with character
                    self.resource = resource
                    cell.viewModel = self.tableViewViewModel?.attributes[indexPath.row]
                    
                    // Reload cell
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                case .failure(let error):
                    resource.charactersDownloadState = .failed
                    print(error)
                }
            }
        }
    }
}
