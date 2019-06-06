//
//  CategoryListController.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class CategoryListController: UITableViewController {
    let dataSource = CategoriesDataSource(categories: [.people, .starships, .vehicles, .films])

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
}

// MARK: - Table View Delegate

extension CategoryListController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = dataSource.category(at: indexPath)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let resourceDetailController = storyboard.instantiateViewController(withIdentifier: "ResourceDetail") as? ResourceDetailController {
            resourceDetailController.category = category
            
            switch category {
            case .people:
                
                // TODO: - ADD [WEAK SELF] TO CLOSURE
             
                
                StarWarsAPIClient<Character>.fetchAll { (result) in
                    switch result {
                    case .success(let resources):
                        resourceDetailController.categoryResources = resources
                        resourceDetailController.smallestResource = resources.smallest
                        resourceDetailController.largestResource = resources.largest
                        self.navigationController?.pushViewController(resourceDetailController, animated: true)
                    case .failure(let error):
                        self.showAlert(title: "Network Error", message: "\(error)")
                    }
                }
                
            case .starships:
                StarWarsAPIClient<Starship>.fetchAll { (result) in
                    switch result {
                    case .success(let resources):
                        resourceDetailController.categoryResources = resources
                        resourceDetailController.smallestResource = resources.smallest
                        resourceDetailController.largestResource = resources.largest
                        self.navigationController?.pushViewController(resourceDetailController, animated: true)
                    case .failure(let error):
                        self.showAlert(title: "Network Error", message: "\(error)")
                    }
                }
                
            case .vehicles:
                StarWarsAPIClient<Vehicle>.fetchAll { (result) in
                    switch result {
                    case .success(let resources):
                        resourceDetailController.categoryResources = resources
                        resourceDetailController.smallestResource = resources.smallest
                        resourceDetailController.largestResource = resources.largest
                        self.navigationController?.pushViewController(resourceDetailController, animated: true)
                    case .failure(let error):
                        self.showAlert(title: "Network Error", message: "\(error)")
                    }
                }
                
            case .films:
                StarWarsAPIClient<Film>.fetchAll { (result) in
                    switch result {
                    case .success(let resources):
                        resourceDetailController.categoryResources = resources
                        resourceDetailController.smallestResource = resources.smallest
                        resourceDetailController.largestResource = resources.largest
                        self.navigationController?.pushViewController(resourceDetailController, animated: true)
                    case .failure(let error):
                        self.showAlert(title: "Network Error", message: "\(error)")
                    }
                }
            }
            
        }
    }
}
