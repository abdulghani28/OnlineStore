//
//  RegisterViewModel.swift
//  DataUtamaTest
//
//  Created by Muhammad Abdul Ghani on 11/01/24.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmedPassword = ""
    @Published var isPasswordConfirmationValid = false
    
    func register() {
        Task {
            do {
                guard let url = URL(string: "https://tes-skill.datautama.com/test-skill/api/v1/auth/register") else {
                    throw URLError(.badURL)
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let json: [String: Any] = [
                    "name": name,
                    "email": email,
                    "password": password
                ]
                
                guard let httpBody = try? JSONSerialization.data(withJSONObject: json, options: []) else {
                    throw URLError(.badServerResponse)
                }
                
                request.httpBody = httpBody
                print("request", request)
                
                let result: RegisterResponse = try await APIService.fetch(request: request)
                
                if result.code == "20000" {
                    print("Register success")
                } else {
                    print("Register failed")
                }
            } catch {
                print("Register failed error: ", error.localizedDescription)
            }
        }
    }
    
    func validatePasswordConfirmation() {
        isPasswordConfirmationValid = password == confirmedPassword
    }

    
}
