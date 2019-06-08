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
    
    // Initiate Results Controller from class
    let resultsController = SearchResultsController()
    
    // Initiate Search Controller
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: resultsController)
        
        searchController.dimsBackgroundDuringPresentation = false
//        searchController.searchResultsUpdater = resultsController
        searchController.searchBar.setDefaultStyle()
        searchController.searchBar.delegate = resultsController
        
        // search bar does not remain on the screen
        // if the user navigates to another view controller
        definesPresentationContext = true
        
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
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
        
        // Set search bar in navigation bar
        navigationItem.searchController = searchController
        
        // Hide border shadow
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
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
            fetch(category, for: resourceDetailController)
        }
    }
    
    // Helper
    
    func fetch(_ category: Category, for viewController: ResourceDetailController) {
        switch category {
        case .people:
            
            // TODO: - ADD [WEAK SELF] TO CLOSURE ?
            
            StarWarsAPIClient<Character>.fetchAll { (result) in
                switch result {
                case .success(let resources):
                    viewController.categoryResources = resources
                    viewController.smallestResource = resources.smallest
                    viewController.largestResource = resources.largest
                    self.navigationController?.pushViewController(viewController, animated: true)
                case .failure(let error):
                    self.showAlert(title: "Network Error", message: "\(error)")
                }
            }
            
        case .starships:
            StarWarsAPIClient<Starship>.fetchAll { (result) in
                switch result {
                case .success(let resources):
                    viewController.categoryResources = resources
                    viewController.smallestResource = resources.smallest
                    viewController.largestResource = resources.largest
                    self.navigationController?.pushViewController(viewController, animated: true)
                case .failure(let error):
                    self.showAlert(title: "Network Error", message: "\(error)")
                }
            }
            
        case .vehicles:
            StarWarsAPIClient<Vehicle>.fetchAll { (result) in
                switch result {
                case .success(let resources):
                    viewController.categoryResources = resources
                    viewController.smallestResource = resources.smallest
                    viewController.largestResource = resources.largest
                    self.navigationController?.pushViewController(viewController, animated: true)
                case .failure(let error):
                    self.showAlert(title: "Network Error", message: "\(error)")
                }
            }
            
        case .films:
            StarWarsAPIClient<Film>.fetchAll { (result) in
                switch result {
                case .success(let resources):
                    viewController.categoryResources = resources
                    viewController.smallestResource = resources.smallest
                    viewController.largestResource = resources.largest
                    self.navigationController?.pushViewController(viewController, animated: true)
                case .failure(let error):
                    self.showAlert(title: "Network Error", message: "\(error)")
                }
            }
        }
    }
}
