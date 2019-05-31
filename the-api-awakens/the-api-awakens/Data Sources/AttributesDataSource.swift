//
//  ResultsListDataSource.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class AttributesDataSource: NSObject, UITableViewDataSource {
    
    private var resource: Resource
    
    private var tableViewViewModel: AttributesTableViewModel {
        switch resource.category {
        case .people: return CharacterViewModel(character: resource as! Character)
        case .starships: return StarshipViewModel(starship: resource as! Starship)
        case .vehicles: return VehicleViewModel(vehicle: resource as! Vehicle)
        }
    }
    
    init(from resource: Resource) {
        self.resource = resource
        super.init()
    }
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewViewModel.attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath) as! AttributeCell
        let attributeViewModel = tableViewViewModel.attributes[indexPath.row]
        
        cell.viewModel = attributeViewModel

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Info"
    }
    
    // MARK: - Helper Methods
    
    func update(with resource: Resource) {
        self.resource = resource
    }
    
}
