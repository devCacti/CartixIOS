//
//  APIEndpoints.swift
//  CartixIOS
//
//  Created by Tiago Laim Rodrigues on 31/10/2026.
//

import Foundation

enum APIEndpoint {
    case login(username: String, password: String)
    case me
    
    // Resolves the method based on the case
    var method: String {
        switch self {
        case .login: return "POST"
        case .me: return "GET"
        }
    }
    
    // Returns the Server URL
    private var baseURL : String {
        return "http://192.168.1.96:5072/api/v1"
    }
    
    // Resolves the path based on the case
    private var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .me:
            return "/auth/me"
        }
    }
    
    // For building the request body
    var body: Data? {
        switch self {
        // Login
        case .login(let username, let password):
            let dictionary = ["username": username, "password": password]
            return try? JSONEncoder().encode(dictionary)
        
        // Me
        case .me:
            return nil
        }
    }
    
    // Combines the base url and path and returns as an usable url
    var url: URL {
        return URL(string: baseURL + path)!
    }
}
