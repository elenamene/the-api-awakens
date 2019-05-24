//
//  StarWarsAPIClient.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 13/05/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

class StarWarsAPIClient<T: Resource> where T: Decodable {
    
    private static var session: URLSession {
        return URLSession(configuration: .default)
    }
    
    private static var decoder: JSONDecoder {
        return JSONDecoder()
    }

    /// Generic method to fetch a collection of resources of type T
    static func fetchAll(completion: @escaping (Result<[T], StarWarsError>) -> Void) {
        
        getCollection(request: T.endpoint.request) { result in
            switch result {
            case .success(let response):
                fetchAllPages(from: response, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Helpers

private extension StarWarsAPIClient {
    
    /// Generic method to fetch all available pages from CollectionResults<T>
    static func fetchAllPages(from response: CollectionResults<T>, completion: @escaping (Result<[T], StarWarsError>) -> Void) {
        let group = DispatchGroup()
        var currentResponse = response
        var totalResults = response.results
        
        DispatchQueue.global().async {
            while let nextPage = currentResponse.next {
                group.enter()
                
                let url = URL(string: nextPage)
                let request = URLRequest(url: url!) // Error badURL
                
                getCollection(request: request) { result in
                    print("Fetching page: \(nextPage)")
                    switch result {
                    case .success(let response):
                        totalResults += response.results
                        currentResponse = response
                        group.leave()
                    case .failure(let error):
                        group.leave()
                        completion(.failure(error))
                    }
                }
                group.wait()
            }
            
            group.notify(queue: .main) {
                completion(.success(totalResults))
            }
        }
    }
    
    /// Generic method to request a collectionResponse with an endpoint of type StarwarsEndpoint
    static func getCollection(request: URLRequest, completion: @escaping (Result<CollectionResults<T>, StarWarsError>) -> Void) {
        performRequest(with: request) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonResponse = try self.decoder.decode(CollectionResults<T>.self, from: data)
                    completion(.success(jsonResponse))
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
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Generic method to perform a generic data request
    static func performRequest(with request: URLRequest, completion: @escaping (Result<Data, StarWarsError>) -> Void) {
        let task = session.dataTask(with: request) { (data, response, error) in
            
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
                
                completion(.success(data))
            }
        }
        
        task.resume()
    }
}


