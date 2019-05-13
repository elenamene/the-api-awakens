//
//  SearchResultsController.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 02/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController {
    
    let dataSource = SearchResultsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        // Register the cell class I want to use in the tableView
        tableView.register(SearchResultsCell.self, forCellReuseIdentifier: SearchResultsCell.reuseIdentifier)
        
        // Table view styling
        tableView.backgroundColor = Color.darkBlue
        tableView.separatorColor = Color.lightBlue
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension SearchResultsController: UISearchResultsUpdating {
    // respond to search bar
    func updateSearchResults(for searchController: UISearchController) {
        let results: [Resource] = Stub.characters + Stub.starships + Stub.vehicles
        dataSource.update(with: results)
        tableView.reloadData()
    }
}

extension SearchResultsController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let resourceDetailController = storyboard.instantiateViewController(withIdentifier: "ResourceDetail") as? ResourceDetailController {
            let selectedResource = dataSource.resource(at: indexPath)
            
            resourceDetailController.category = selectedResource.category
            let index = resourceDetailController.pickerDataSource.index(of: selectedResource)!
            
            resourceDetailController.pickerView.selectRow(index, inComponent: 0, animated: true)
            
            presentingViewController?.navigationController?.pushViewController(resourceDetailController, animated: true)
        }
    }
}
