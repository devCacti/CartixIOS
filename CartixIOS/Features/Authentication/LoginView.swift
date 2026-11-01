//
//  LoginView.swift
//  CartixIOS
//
//  Created by Tiago Laim Rodrigues on 31/10/2026.
//

import SwiftUI

struct LoginView: View {
    // View Model
    @StateObject private var viewModel = LoginViewModel()
    
    enum Field: Hashable {
        case username, password
    }
    
    @FocusState private var focusedField: Field?
    @State private var isPasswordVisible = false
    
    private var isFormValid: Bool {
        return !viewModel.username.trimmingCharacters(in: .whitespaces).isEmpty && !viewModel.password.isEmpty && !viewModel.isLoading
    }
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 20) {
                // Username Field
                HStack {
                    // Person Icon
                    Image(systemName: "person")
                        .foregroundColor(.secondary)
                        .frame(width: 24)
                    // Username Field
                    TextField(String(localized: "login_username_placeholder"), text: $viewModel.username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .submitLabel(.next)
                        .focused($focusedField, equals: .username)
                        .onSubmit {
                            focusedField = .password
                        }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                    
                
                // Password Field
                HStack {
                    // Lock icon
                    Image(systemName: "lock")
                        .foregroundColor(.secondary)
                        .frame(width: 24)
                    
                    // Switch from visible to not visible field
                    Group {
                        if isPasswordVisible {
                            TextField(String(localized: "login_password_placeholder"), text: $viewModel.password)
                        }else {
                            SecureField(String(localized: "login_password_placeholder"), text: $viewModel.password)
                        }
                    }
                    .submitLabel(.go)
                    .focused($focusedField, equals: .password)
                    .onSubmit {
                        focusedField = nil
                        Task { await viewModel.login() }
                    }
                    
                    // View Password Button
                    Button(action: { isPasswordVisible.toggle() }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.secondary)
                            .padding(.leading, 8)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
            }
            
            // Error Message
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }
            
            // Login Button (Or progressview)
            if (viewModel.isLoading) {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
            } else {
                Button(action: { Task { await viewModel.login() } }) {
                    Text(String(localized: "login_button_placeholder"))
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                }
                .buttonStyle(.plain)
                .background(isFormValid ? Color.accentColor : Color(.systemGray5))
                .foregroundColor(isFormValid ? .white : Color(.systemGray2))
                .cornerRadius(16)
                .disabled(!isFormValid)
            }
            
        }
        .padding()
        .onTapGesture {
            focusedField = nil
        }
    }
}

#Preview {
    LoginView()
}
