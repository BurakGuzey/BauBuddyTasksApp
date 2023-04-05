//
//  ServiceConstants.swift
//  TasksApp
//
//  Created by Burak Güzey on 5.04.2023.
//

import Foundation

struct ServiceConstants {
    
    struct BaseConstants {
        
        static let baseURL = "api.baubuddy.de"
        static let baseScheme = "https"
        static let basePath = "/dev/index.php/v1/tasks/select"
        
    }
   
    struct AuthConstants {
        
        static var accessToken = "access_token"
        static var expiresIn = "expires_in"
        static var tokenType = "token_type"
        static var refreshToken = "refresh_token"
        static var accessTokenValue = String()
        static var expiresInValue = String()
        static var tokenTypeValue = String()
        static var refreshTokenValue = String()
        static let resourceURL = "https://api.baubuddy.de/index.php/login"
        static let headerDic1 = ["Authorization": "Basic QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz",
                                 "Content-Type": "application/json"]
        static let parameters = [
            "username": "365",
            "password": "1"
        ]
    }
    
    struct TabBarConstants {
        
        static let vc1 = "Task"
        static let vc2 = "Search"
        static let vc3 = "Scan"
        
        static let vc1ImageName = "case.fill"
        static let vc2ImageName = "magnifyingglass"
        static let vc3ImageName = "barcode.viewfinder"
        
    }
    
    struct CellConstants {
        
        static let TaskListCell = "TaskListTableViewCell"
    }
}

