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
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        return decoder
    }
    
    static func fetch(_ urls: [URL], completion: @escaping (Result<[T], StarWarsError>) -> Void) {
        let group = DispatchGroup()
        var resources: [T] = []
        print(urls)
        DispatchQueue.global(qos: .background).async {
            for url in urls {
                group.enter()
                print("Fetching \(url)")
                fetch(url: url) { result in
                    switch result {
                    case .success(let resource):
                        print("Fetched completed: \(resource.name), \(url)")
                        resources.append(resource)
                        group.leave()
                    case .failure(let error):
                        group.leave()
                        completion(.failure(error))
                    }
                }
            }
            
            group.wait()
            
            DispatchQueue.main.async {
                print("Completion: downloaded \(resources.count) resoureces")
                completion(.success(resources))
            }
        }
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
    
    /// Generic method to fetch a single resources of type T
    static func fetch(url: URL, completion: @escaping (Result<T, StarWarsError>) -> Void) {
        let request = URLRequest(url: url)
        
        getResource(request: request) { result in
            switch result {
            case .success(let resource):
                completion(.success(resource))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Generic method to fetch all available pages from CollectionResults<T>
    static func fetchAllPages(from response: CollectionResults<T>, completion: @escaping (Result<[T], StarWarsError>) -> Void) {
        let group = DispatchGroup()
        var currentResponse = response
        var totalResults = response.results
   
        DispatchQueue.global(qos: .background).async {
            while let nextPage = currentResponse.next {
                group.enter()

                guard let url = URL(string: nextPage) else {
                    completion(.failure(StarWarsError.badURL))
                    return
                }

                let request = URLRequest(url: url)

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
                print("Fetched all pages, results: \(totalResults.count)")
                completion(.success(totalResults))
            }
        }
    }
    
    /// Generic method to request a resource
    static func getResource(request: URLRequest, completion: @escaping (Result<T, StarWarsError>) -> Void) {
        performRequest(with: request) { result in
            switch result {
            case .success(let data):
                do {
                    let resource = try self.decoder.decode(T.self, from: data)
                    completion(.success(resource))
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
    
    /// Generic method to request a collectionResponse
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
    
    /// Generic method to perform a data request
    static func performRequest(with request: URLRequest, completion: @escaping (Result<Data, StarWarsError>) -> Void) {
        let task = session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(StarWarsError.requestFailed(description: error?.localizedDescription ?? "No description")))
                    return
                }
                
                guard httpResponse.statusCode == 200  else {
                    completion(.failure(StarWarsError.responseUnsuccessful(description: "\(httpResponse.statusCode)")))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(StarWarsError.invalidData))
                    return
                }
                
                completion(.success(data))
            }
        }
        
        task.resume()
    }
}


