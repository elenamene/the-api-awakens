//
//  CategoriesListController.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class CategoriesMainController: UITableViewController {
    
    let dataSource = CategoriesListDataSource(categories: [.people, .starships, .vehicles])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSearchController()
        setupTableView()
    }
    
    // MARK: - Initial Setup
    
    func setupTableView() {
        tableView.dataSource = dataSource
        tableView.backgroundColor = Colors.darkBlue
    }
    
    func setupNavigationBar() {
        // Add logo
        let titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 24))
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.image = #imageLiteral(resourceName: "logo")
        navigationItem.titleView = titleImageView
        
        // Hide border shadow
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    func setupSearchController() {
        // Initiate Results Controller from class
        let resultsController = SearchResultsController()
        
        // Initiate Search Controller
        let searchController = UISearchController(searchResultsController: resultsController)
        
        searchController.searchBar.placeholder = "Characters, Starships or Vehicles"
        searchController.dimsBackgroundDuringPresentation = false 
        searchController.searchResultsUpdater = resultsController
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResults" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let category = dataSource.category(at: indexPath)
             
                // Call to API to get all the resources of the category
                
                // Assign artist to the next view controller
                let categoryResultsController = segue.destination as! CategoryResultsController
                categoryResultsController.category = category
                
                categoryResultsController.pickerDataSource.update(with: category.stubData)
            }
        }
    }
}

// MARK: - Table View Delegate

extension CategoriesMainController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
}
