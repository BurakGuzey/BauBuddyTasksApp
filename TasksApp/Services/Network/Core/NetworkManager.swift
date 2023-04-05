//
//  NetworkManager.swift
//  TasksApp
//
//  Created by Burak Güzey on 5.04.2023.
//

import Foundation

struct NetworkManager {
    
    private let session = URLSession.shared
    
    func requestAuth(completion: @escaping (Result<OauthType, Error>) -> Void) {
        let headers = ServiceConstants.AuthConstants.headerDic1
        let parameters = ServiceConstants.AuthConstants.parameters as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: ServiceConstants.AuthConstants.resourceURL)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = HTTPMethod.post.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            let httpResponse = response as? HTTPURLResponse
            
            DispatchQueue.main.async {
                if let safeData = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let model = try decoder.decode(OauthType.self, from: safeData)
                        completion(.success(model))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    
    func performRequest<T: Codable>(request: Requestable, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let task = session.dataTask(with: request.toURLRequest()) { (data, response, error) in
            DispatchQueue.main.async {
                if let safeData = data {
                    do {
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(T.self, from: safeData)
                        completion(.success(model))
                    } catch {
                        completion(.failure(.decodingError))
                    }
                } else if error != nil {
                    completion(.failure(.netWorkError))
                } else {
                    completion(.failure(.unknownError))
                }
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    
    case decodingError
    case netWorkError
    case unknownError
    
}
