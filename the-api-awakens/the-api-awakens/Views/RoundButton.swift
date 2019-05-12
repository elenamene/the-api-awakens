//
//  UIButton.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 12/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation
import UIKit

class RoundButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.layer.borderColor = Color.lightBlue.cgColor
        self.layer.borderWidth = 1
        backgroundColor = Color.darkBlue
    }

    override var isSelected: Bool {
        didSet {
            layer.shadowColor = Color.lightBlue.cgColor
            layer.shadowOpacity = isSelected ? 1.0 : 0.0
            layer.shadowRadius = 10
            layer.shadowOffset = .zero
        }
    }
}
