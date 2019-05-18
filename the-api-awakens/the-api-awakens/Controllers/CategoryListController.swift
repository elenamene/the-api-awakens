//
//  CategoryListController.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class CategoryListController: UITableViewController {
    
    let client = StarWarsAPIClient()
    let dataSource = CategoryListDataSource(categories: [.people, .starships, .vehicles])

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
        print("tapped on \(category.name)")
        
        if let resourceDetailController = storyboard.instantiateViewController(withIdentifier: "ResourceDetail") as? ResourceDetailController {
            resourceDetailController.category = category
            print("Category Passed to vc: \(resourceDetailController.category!.name)")
            
            client.fetch(category) { result in
                print("fetching...")
                
                switch result {
                case .success(let resources):
                    print("success")
                    resources.forEach() { print($0) }
                    resourceDetailController.categoryResources = resources
                    
                    self.navigationController?.pushViewController(resourceDetailController, animated: true)
                    
                case .failure(let error):
                    print(error)
                    
                    let alertController = UIAlertController(title: "Something went wrong", message: "\(error)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(action)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
}
