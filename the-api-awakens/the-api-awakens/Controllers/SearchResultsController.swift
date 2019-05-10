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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchResultsCell")
    }
}

extension SearchResultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dataSource.update(with: Stub.characters)
        tableView.reloadData()
    }
}
