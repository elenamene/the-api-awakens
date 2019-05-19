//
//  StarWarsAPIClient.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 13/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

class StarWarsAPIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: URLSessionConfiguration.default)
    }
    
    let decoder = JSONDecoder()
    
    func fetch(_ category: Category, completion: @escaping (Result<[Resource], StarWarsError>) -> Void) {
        performRequestWith(endpoint: category.endpoint) { result in
            completion(result)
        }
    }
}

private extension StarWarsAPIClient {
    func performRequestWith(endpoint: StarWarsEndpoint, completion: @escaping (Result<[Resource], StarWarsError>) -> Void) {
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
                    switch endpoint {
                    case .people:
                        let jsonResponse = try self.decoder.decode(JSONResponse<Character>.self, from: data)
                         completion(.success(jsonResponse.results))
                    case .vehicles:
                        let jsonResponse = try self.decoder.decode(JSONResponse<Vehicle>.self, from: data)
                         completion(.success(jsonResponse.results))
                    case .starships:
                        let jsonResponse = try self.decoder.decode(JSONResponse<Starship>.self, from: data)
                         completion(.success(jsonResponse.results))
                    }
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        }
        
        task.resume()
    }
}


