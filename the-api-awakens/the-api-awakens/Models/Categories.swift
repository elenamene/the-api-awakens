//
//  Categories.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 01/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation
import UIKit

enum Category {
    case people
    case vehicles
    case starships
}

extension Category {
    var name: String {
        switch self {
        case .people: return "Characters"
        case .vehicles: return "Vehicles"
        case .starships: return "Starships"
        }
    }
    
    var iconImage: UIImage {
        switch self {
        case .people: return #imageLiteral(resourceName: "icon-characters")
        case .vehicles: return #imageLiteral(resourceName: "icon-vehicles")
        case .starships: return #imageLiteral(resourceName: "icon-starships")
        }
    }
    
    var stubData: [Resource] {
        switch self {
        case .people: return Stub.characters
        case .vehicles: return Stub.vehicles
        case .starships: return Stub.starships
        }
    }
}
