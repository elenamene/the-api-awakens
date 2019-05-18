//
//  String.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 10/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        let string = NSString(string: self)
        return String(string.capitalized)
    }
}
