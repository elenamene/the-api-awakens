//
//  SearchResultsDataSource.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 03/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class SearchResultsDataSource: NSObject, UITableViewDataSource {
    private var data = [Character]()
    
    override init() {
        super.init()
    }
    
    func update(with results: [Character]) {
        data = results
    }
    
    // MARK: Table View Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultsCell", for: indexPath)
        let character = data[indexPath.row]
        cell.textLabel?.text = character.name
        
        return cell
    }
}
