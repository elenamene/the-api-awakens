//
//  CategoryListController.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class CategoryListController: UITableViewController {
    
    let dataSource = CategoryListDataSource(categories: [.people, .starships, .vehicles])
    let client = StarWarsAPIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSearchController()
        setupTableView()
    }
    
    // MARK: - Initial Setup
    
    func setupTableView() {
        tableView.dataSource = dataSource
        tableView.backgroundColor = Color.darkBlue
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
        
        // Set search bar in navigation bar
        navigationItem.searchController = searchController
        
        searchController.dimsBackgroundDuringPresentation = false 
        searchController.searchResultsUpdater = resultsController
        searchController.searchBar.setDefaultStyle()
        
        // search bar does not remain on the screen
        // if the user navigates to another view controller
        definesPresentationContext = true
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResults" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let category = dataSource.category(at: indexPath)
                
                // Assign artist to the next view controller
                let categoryResultsController = segue.destination as! ResourceDetailController
                categoryResultsController.category = category
                
                // Call to API to get all the resources of the category
                
                client.fetchAllResources(for: category) { result in
                    switch result {
                    case .success(let resources): categoryResultsController.pickerDataSource.update(with: resources)
                    case .failure(let error): print(error)
                    }
                }
             }
        }
    }
}

// MARK: - Table View Delegate

extension CategoryListController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
}
