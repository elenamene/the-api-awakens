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
            }
        }
    }
    
    private var tableViewViewModel: AttributesTableViewModel?
    
    private let viewController: ResourceDetailController
    
    init(from resource: Resource, viewController: ResourceDetailController) {
        self.resource = resource
        self.viewController = viewController
        
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
        fetchVehicleNamesFor(cell, at: indexPath)
        fetchStarshipNamesFor(cell, at: indexPath)
        
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
        if cell.viewModel?.name == "Vehicles", let character = resource as? Character, character.vehiclesDownloadState == .notDownloaded {
            let urls = character.vehicles.map { URL(string: $0)! }
            
            StarWarsAPIClient<Vehicle>.fetch(urls) { result in
                switch result {
                case .success(let vehicles):
                    // Assign the vehicles back to the resource
                    character.vehiclesDownloaded = vehicles
                    character.vehiclesDownloadState = .downloaded
                    // Update cell viewModel with character
                    self.resource = character
                    cell.viewModel = self.tableViewViewModel?.attributes[indexPath.row]
                case .failure(let error):
                    character.vehiclesDownloadState = .failed
                    print(error)
                }
            }
        }
    }
    
    func fetchStarshipNamesFor(_ cell: AttributeCell, at indexPath: IndexPath) {
        if cell.viewModel?.name == "Starships", let character = resource as? Character, character.starshipsDownloadState == .notDownloaded {
            let urls = character.starships.map { URL(string: $0)! }
            print("Fetching \(urls.count) urls")
            StarWarsAPIClient<Starship>.fetch(urls) { result in
                switch result {
                case .success(let starships):
                    print("Fetched starships: \(starships.map { $0.name })")
                    // Assign the vehicles back to the resource
                    character.starshipsDownloaded = starships
                    character.starshipsDownloadState = .downloaded
                    // Update cell viewModel with character
                    self.resource = character
                    cell.viewModel = self.tableViewViewModel?.attributes[indexPath.row]
                case .failure(let error):
                    character.starshipsDownloadState = .failed
                    print(error)
                }
            }
        }
    }
    
    
    
//    func fetchFilmNamesFor(_ cell: AttributeCell, at indexPath: IndexPath) {
//        if let character = resource as? Character, character.filmsDownloadState == .notDownloaded {
//            let urls = character.films.map { URL(string: $0)! }
//
//            StarWarsAPIClient<Film>.fetch(urls) { result in
//                switch result {
//                case .success(let starships):
//                    // Assign the vehicles back to the resource
//                    character.starshipsDownloaded = starships
//                    character.starshipsDownloadState = .downloaded
//                    // Update cell viewModel with character
//                    self.resource = character
//                    cell.viewModel = self.tableViewViewModel?.attributes[indexPath.row]
//                case .failure(let error):
//                    character.starshipsDownloadState = .failed
//                    print(error)
//                }
//            }
//        }
//    }
    

}
