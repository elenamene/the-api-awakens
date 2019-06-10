//
//  UIViewController.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 19/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Alert Helpers

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithTextInput(title: String,
                                message: String,
                                inputPlaceholder: String? = nil,
                                inputKeyboardType: UIKeyboardType = UIKeyboardType.default,
                                actionTitle: String? = "Add",
                                cancelTitle: String? = "Cancel",
                                cancelHandler: ((UIAlertAction) -> Void)? = nil,
                                actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        
        let action = UIAlertAction(title: actionTitle, style: .default) { (UIAlertAction) in
            guard let textField = alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            
            actionHandler?(textField.text)
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler)
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
