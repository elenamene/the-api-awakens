//
//  UISearchBar.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 13/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    var textField: UITextField? {
        for subview in subviews.first?.subviews ?? [] {
            if let textField = subview as? UITextField {
                return textField
            }
        }
        return nil
    }
    
    func setDefaultStyle() {
        tintColor = Color.red
        placeholder = "Search for name or model"
        barStyle = .black
    }
}
