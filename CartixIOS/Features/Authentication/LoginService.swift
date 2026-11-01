//
//  LoginService.swift
//  CartixIOS
//
//  Created by Tiago Laim Rodrigues on 31/10/2026.
//

import Foundation

class LoginService {
    private let apiClient = APIClient.shared
    
    func authenticate(username: String, password: String) async throws -> String {
        let response: AuthResponse = try await apiClient.request(.login(username: username, password: password))
        return response.token
    }
}

struct AuthResponse: Decodable {
    let token: String
}
