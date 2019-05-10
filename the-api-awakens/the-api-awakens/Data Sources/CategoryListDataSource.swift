//
//  CategoriesListDataSource.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class CategoryListDataSource: NSObject {
    private var data: [Category] = []
    
    init(categories: [Category]) {
        self.data = categories
        super.init()
    }
}

extension CategoryListDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as? CategoryCell else { fatalError() }
        let category = data[indexPath.row]
        cell.categoryIcon.image = category.iconImage
        cell.categoryNameLabel.text = category.name
            
        return cell
    }
    
    // MARK: - Helper Methods
    
    func category(at indexPath: IndexPath) -> Category {
        return data[indexPath.row]
    }
}
