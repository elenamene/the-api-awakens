//
//  SearchResultsCell.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 12/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class SearchResultsCell: UITableViewCell {
    
    // MARK - Properties
    
    static let reuseIdentifier = "SearchResultsCell"
    
    // MARK - Cell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // init from interface builder
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Color.darkBlue
        textLabel?.textColor = .white
        selectionStyle = .none
        
        // Add target to show segue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            backgroundColor = Color.selectedItem
        } else {
            backgroundColor = Color.darkBlue
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRect(x: 16, y: 10, width: 25, height: 25)
        textLabel?.frame = CGRect(x: 56, y: 12, width: 400, height: 20)
    }
    
    // MARK - Actions
    
//    @objc func showResourceDetail(sender: Any) {
//        print("test")
//    }

}
