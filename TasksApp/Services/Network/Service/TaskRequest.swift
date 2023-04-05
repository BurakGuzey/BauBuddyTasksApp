//
//  TaskRequest.swift
//  TasksApp
//
//  Created by Burak Güzey on 5.04.2023.
//

import Foundation

enum Taskrequest {
    
    case task
    
}

extension Taskrequest: Requestable {
    
    var queryItems: [URLQueryItem] {
        return  [
            URLQueryItem(name: ServiceConstants.AuthConstants.accessToken, value: ServiceConstants.AuthConstants.accessTokenValue),
            URLQueryItem(name: ServiceConstants.AuthConstants.expiresIn, value: ServiceConstants.AuthConstants.expiresInValue),
            URLQueryItem(name: ServiceConstants.AuthConstants.tokenType, value: ServiceConstants.AuthConstants.tokenTypeValue),
            URLQueryItem(name: ServiceConstants.AuthConstants.refreshToken, value: ServiceConstants.AuthConstants.refreshTokenValue)
        ]
    }
   
    var method: HTTPMethod {
        switch self {
        case .task:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .task:
            return ServiceConstants.BaseConstants.basePath
        }
    }
    
    var parameters: Data? {
        switch self {
        case .task:
            return nil
        }
    }
}
