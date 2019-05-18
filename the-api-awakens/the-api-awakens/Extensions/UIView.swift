//
//  UIView.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 12/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 1, offSet: CGSize = .zero, radius: CGFloat = 10) {
        layer.masksToBounds = false
        layer.shadowColor = Color.lightBlue.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
}
