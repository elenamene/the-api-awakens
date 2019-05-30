//
//  Endpoint.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 13/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var queryItem: URLQueryItem? { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        
        if let queryItem = queryItem {
            components.queryItems = [queryItem]
        }
        
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        
        return URLRequest(url: url)
    }
}

// MARK: - Star Wars Endpoint

enum StarWarsEndpoint: String {
    case people
    case starships
    case vehicles
}

extension StarWarsEndpoint: Endpoint {
    var base: String {
        return "https://swapi.co"
    }
    
    var path: String {
        return "/api/\(self.rawValue)"
    }
    
    var queryItem: URLQueryItem? {
        return nil
    }
}
