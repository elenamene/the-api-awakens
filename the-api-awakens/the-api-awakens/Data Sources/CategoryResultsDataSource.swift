//
//  ResultsListDataSource.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class CategoryResultsDataSource: NSObject, UITableViewDataSource {
    private var resources: [Resource]
    
    init(resources: [Resource]) {
        self.resources = resources
        super.init()
    }
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultDetailCell", for: indexPath)
        let resource = resources[indexPath.row]
        cell.textLabel?.text = resource.name
        cell.detailTextLabel?.text = "more info here"
        
        return cell
    }
    
}
