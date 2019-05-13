//
//  SearchResultsDataSource.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 03/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class SearchResultsDataSource: NSObject, UITableViewDataSource {
    private var results = [Resource]()
    
    override init() {
        super.init()
    }
    
    func update(with results: [Resource]) {
        self.results = results
    }
    
    // MARK: Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsCell.reuseIdentifier, for: indexPath) as! SearchResultsCell
        
        let character = results[indexPath.row]
        
        cell.textLabel?.text = character.name
        cell.imageView?.image = character.category.iconImage
        
        return cell
    }
    
    // MARK: - Helper
    
    func resource(at indexPath: IndexPath) -> Resource {
        return results[indexPath.row]
    }
}
