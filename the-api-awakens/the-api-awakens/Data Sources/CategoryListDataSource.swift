//
//  CategoriesListDataSource.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class CategoryListDataSource: NSObject {
    private var categories: [Category] = []
    
    init(categories: [Category]) {
        self.categories = categories
        super.init()
    }
}

extension CategoryListDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as? CategoryCell else { fatalError() }
        
        let category = categories[indexPath.row]
        
        cell.categoryIcon.image = category.iconImage
        cell.categoryNameLabel.text = category.name
            
        return cell
    }
    
    // MARK: - Helper Methods
    
    func category(at indexPath: IndexPath) -> Category {
        return categories[indexPath.row]
    }
}
