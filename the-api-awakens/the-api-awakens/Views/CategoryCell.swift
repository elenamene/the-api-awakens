//
//  CategoryCell.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    static let reuseIdentifier = "CategoryCell"
    
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            containerView.backgroundColor = Color.selectedCardBlue
            categoryNameLabel.textColor = Color.lightBlue
        } else {
            containerView.backgroundColor = Color.defaultCardBlue
            categoryNameLabel.textColor = .white
        }
    }
    
    // Mark: - Helper Methods
    
    func addStyle() {
        containerView.layer.cornerRadius = 8
        
        // shadow
        containerView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowOpacity = 0.4
    }

}
