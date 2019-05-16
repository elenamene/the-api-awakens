//
//  StarWarsAPIClient.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 13/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

//enum Result<Value> {
//    case success(Value)
//    case failure(Error)
//}

/*
 client.fetch(category: .people) { result in
 switch result {
 case .success(let resources): vc.picker.datasource.update
 case .failure(let error):
 }
 }
 }
 */

class StarWarsAPIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    let decoder = JSONDecoder()
    
    func fetchAllResources<T: Decodable>(for category: Category, completion: @escaping (Result<[T], StarWarsError>) -> Void) {
        performRequestWith(endpoint: category.endpoint) { result in
           completion(result)
        }
    }
}

extension StarWarsAPIClient {
    /// Generic func to download json with format: JSONResponse<T>
    private func performRequestWith<T: Decodable>(endpoint: StarWarsEndpoint, completion: @escaping (Result<[T], StarWarsError>) -> Void) {
        
        let task = session.dataTask(with: endpoint.request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(.failure(StarWarsError.invalidData))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(StarWarsError.requestFailed(description: error?.localizedDescription ?? "No description")))
                    return
                }
                
                guard httpResponse.statusCode == 200  else {
                    completion(.failure(StarWarsError.responseUnsuccessful(description: "\(httpResponse.statusCode)")))
                    return
                }
                
                do {
                    let jsonResponse = try self.decoder.decode(JSONResponse<T>.self, from: data)
                    let results = jsonResponse.results
                    completion(.success(results))
                } catch let error {
                    completion(.failure(StarWarsError.jsonConversionFailure(description: "\(error.localizedDescription)")))
                }
            }
        }
        
        task.resume()
    }
}

