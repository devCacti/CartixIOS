//
//  LoginViewModel.swift
//  CartixIOS
//
//  Created by Tiago Laim Rodrigues on 31/10/2026.
//

import Foundation
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // The view model owns an instance of the LoginService
    private let loginService = LoginService()
    
    func login() async {
        guard !username.isEmpty, !password.isEmpty, !isLoading else {return}
        
        isLoading = true
        errorMessage = nil
        
        do {
            let token = try await loginService.authenticate(username: username, password: password)
        } catch {
            errorMessage = "Invalid credentials. Please try again."
        }
        
        isLoading = false
    }
}
