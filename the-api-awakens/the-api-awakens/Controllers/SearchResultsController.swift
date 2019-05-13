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
        
        // Register the cell class I want to use in the tableView
        tableView.register(SearchResultsCell.self, forCellReuseIdentifier: SearchResultsCell.reuseIdentifier)
        
        // Table view styling
        tableView.backgroundColor = Color.darkBlue
        tableView.separatorColor = Color.lightBlue
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension SearchResultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let results: [Resource] = Stub.characters + Stub.starships + Stub.vehicles
        dataSource.update(with: results)
        tableView.reloadData()
    }
}
