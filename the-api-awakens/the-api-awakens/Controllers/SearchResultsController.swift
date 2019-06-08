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
    
    var allResources: [Resource] = []
    
    var filteredResults: [Resource] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        // Register the cell class I want to use inside the tableView
        tableView.register(SearchResultsCell.self, forCellReuseIdentifier: SearchResultsCell.reuseIdentifier)
        
        // Table view styling
        tableView.backgroundColor = Color.darkBlue
        tableView.separatorColor = Color.selectedItem
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        fetchAllResources()
    }
    
    func fetchAllResources() {
        StarWarsAPIClient<Character>.fetchAll { result in
            switch result {
            case .success(let results):
                self.allResources.append(contentsOf: results)
                self.dataSource.add(self.allResources)
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(title: "Network Error", message: "\(error)")
            }
        }
        
        StarWarsAPIClient<Vehicle>.fetchAll { result in
            switch result {
            case .success(let results):
                self.allResources.append(contentsOf: results)
                self.dataSource.add(self.allResources)
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(title: "Network Error", message: "\(error)")
            }
        }
        
        StarWarsAPIClient<Starship>.fetchAll { result in
            switch result {
            case .success(let results):
                self.allResources.append(contentsOf: results)
                self.dataSource.add(self.allResources)
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(title: "Network Error", message: "\(error)")
            }
        }
        
        StarWarsAPIClient<Film>.fetchAll { result in
            switch result {
            case .success(let results):
                self.allResources.append(contentsOf: results)
                self.dataSource.add(self.allResources)
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(title: "Network Error", message: "\(error)")
            }
        }
    }
}

// MARK: - SearchBar Delegate

extension SearchResultsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredResults = allResources
            return
        }
        
        filteredResults = allResources.filter({ resource -> Bool in
            return resource.name.lowercased().contains(searchText.lowercased())
        })
        
        dataSource.update(with: filteredResults)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
}

// MARK: - TableView Delegate

extension SearchResultsController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let resourceDetailController = storyboard.instantiateViewController(withIdentifier: "ResourceDetail") as? ResourceDetailController {
            let selectedResource = dataSource.resource(at: indexPath)
            let category = selectedResource.category
            
            present(resourceDetailController, for: category, with: selectedResource)
        }
    }
    
    // Helper
    
    func present(_ viewController: ResourceDetailController, for category: Category, with selectedResource: Resource) {
        viewController.category = category
        viewController.selectedResource = selectedResource
        
        switch category {
        case .people:
            
            // TODO: - ADD [WEAK SELF] TO CLOSURE ?
            
            StarWarsAPIClient<Character>.fetchAll { (result) in
                switch result {
                case .success(let resources):
                    viewController.categoryResources = resources
                    viewController.smallestResource = resources.smallest
                    viewController.largestResource = resources.largest
                    self.presentingViewController?.navigationController?.pushViewController(viewController, animated: true)
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
                    self.presentingViewController?.navigationController?.pushViewController(viewController, animated: true)
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
                    self.presentingViewController?.navigationController?.pushViewController(viewController, animated: true)
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
                    self.presentingViewController?.navigationController?.pushViewController(viewController, animated: true)
                case .failure(let error):
                    self.showAlert(title: "Network Error", message: "\(error)")
                }
            }
        }
    }
    
}
