//
//  Oauth.swift
//  TasksApp
//
//  Created by Burak Güzey on 5.04.2023.
//

import Foundation

struct Oauth: Codable {
    
    let accessToken: String?
    let expiresIn: Int?
    let tokenType: String?
    let refreshToken: String?
    
}

struct OauthType: Codable {
    
    let oauth: Oauth?
    
}
