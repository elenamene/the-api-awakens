//
//  ResultsListDataSource.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class ResourceDetailDataSource: NSObject, UITableViewDataSource {
    
    private var resource: Resource
    
    private var viewModel: AttributesViewModel {
        switch resource.category {
        case .people: return CharacterAttributesViewModel(character: resource as! Character)
        case .starships: return StarshipAttributesViewModel(starship: resource as! Starship)
        case .vehicles: return VehicleAttributesViewModel(vehicle: resource as! Vehicle)
        }
    }
    
    init(resource: Resource) {
        self.resource = resource
        super.init()
    }
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath)
        let attribute = viewModel.attributes[indexPath.row]
        
        cell.textLabel?.text = attribute.name
        cell.detailTextLabel?.text = attribute.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Informations"
    }
    
    // MARK: - Helper Methods
    
    func update(with resource: Resource) {
        self.resource = resource
    }
    
}
