//
//  StarWarsError.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 13/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

enum StarWarsError: Error {
    case invalidData
    case requestFailed(description: String)
    case jsonConversionFailure(description: String)
    case responseUnsuccessful(description: String)
    case jsonParsingFailure(description: String)
    case badURL
}

extension StarWarsError {
    var localizedDescription: String {
        switch self {
        case .invalidData: return "Invalid Data"
        case .requestFailed(let description): return "Request Failed -> \(description)"
        case .jsonConversionFailure(let description): return "JSON Conversion Failure: \(description)"
        case .responseUnsuccessful(let description): return "Response Unsuccessful status code: \(description)"
        case .jsonParsingFailure(let description): return "JSON Parsin Failure: \(description)"
        case .badURL: return "URL Not Valid"
        }
    }
}
