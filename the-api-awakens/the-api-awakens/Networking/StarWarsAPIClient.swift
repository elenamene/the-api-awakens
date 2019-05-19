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
    
    // Specific
    
//    static func fetchAllCharacters(completion: @escaping (Result<[Character], StarWarsError>) -> Void) {
//        performRequestWith(endpoint: StarWarsEndpoint.people) { (result) in
//            if let result = result as? Result<JSONResponse<Character>, StarWarsError> {
//                switch result {
//                case .success(let response): completion(.success(response.results))
//                case .failure(let error): completion(.failure(error))
//                }
//            }
//        }
//    }
    

    /// Generic method to fetch all resources of type T
    /// At completion will return an array of resources of type T or a StarWarsError
    static func fetchAll(completion: @escaping (Result<[T], StarWarsError>) -> Void) {
        performRequestWith(endpoint: T.endpoint) { result in
            switch result {
            case .success(let response):
                let resources = response.results
                completion(.success(resources))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

private extension StarWarsAPIClient {
    /// Generic method to perform a request with an endpoint of type StarwarsEndpoint
    /// At completion will return a response ot type JSONResponse<T> or a StarWarsError
    static func performRequestWith(endpoint: StarWarsEndpoint, completion: @escaping (Result<JSONResponse<T>, StarWarsError>) -> Void) {
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
            }
        }
        
        task.resume()
    }
}


