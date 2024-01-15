//
//  LoginViewModel.swift
//  DataUtamaTest
//
//  Created by Muhammad Abdul Ghani on 11/01/24.
//

import Foundation

class AuthService: ObservableObject {
    @Published var token = ""
    static let shared = AuthService()

    private init() {}

    func setToken(_ newToken: String) {
        token = newToken
    }
}

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLogin = false
    @Published var tokenLogin = ""

    func login() async {
        do {
            guard let url = URL(string: "https://tes-skill.datautama.com/test-skill/api/v1/auth/login") else {
                throw URLError(.badURL)
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let json: [String: Any] = [
                "email": email,
                "password": password
            ]

            guard let httpBody = try? JSONSerialization.data(withJSONObject: json, options: []) else {
                throw URLError(.badServerResponse)
            }

            request.httpBody = httpBody
            print("request", request)

            let result: LoginResponse = try await APIService.fetch(request: request)

            if result.code == "20000" {
                AuthService.shared.setToken(result.data.token)
                await ProductViewModel(variantViewModel: VariantViewModel()).getProductList(token: AuthService.shared.token)
                self.isLogin = true
            }
        } catch {
            print("Login failed error: ", error.localizedDescription)
        }
    }
}

