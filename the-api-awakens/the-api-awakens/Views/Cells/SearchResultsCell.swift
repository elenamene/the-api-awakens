//
//  SearchResultsCell.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 12/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class SearchResultsCell: UITableViewCell {
    
    static let reuseIdentifier = "SearchResultsCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // init from interface builder
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Color.darkBlue
        textLabel?.textColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
