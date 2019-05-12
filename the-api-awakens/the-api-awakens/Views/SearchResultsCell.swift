//
//  SearchResultsCell.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 12/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

class SearchResultsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
                self.backgroundColor = Color.darkBlue
                self.textLabel?.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
