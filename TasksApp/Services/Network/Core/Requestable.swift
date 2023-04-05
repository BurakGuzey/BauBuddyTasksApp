//
//  Requestable.swift
//  TasksApp
//
//  Created by Burak Güzey on 5.04.2023.
//

import Foundation

protocol Requestable {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Data? { get }
    var queryItems: [URLQueryItem] { get }
    
    func toURLRequest() -> URLRequest
    
}

extension Requestable {
    
    var baseURL: String {
        return ServiceConstants.BaseConstants.baseURL
    }
    
    func toURLRequest() -> URLRequest {
        
        let request: URLRequest
        var components = URLComponents()
        components.scheme = ServiceConstants.BaseConstants.baseScheme
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems

        let urlRequest = components.url
        request = URLRequest(url: urlRequest!)

        return request
        
    }
}
