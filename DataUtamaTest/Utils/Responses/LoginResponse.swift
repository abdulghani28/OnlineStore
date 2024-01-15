//
//  LoginResponses.swift
//  DataUtamaTest
//
//  Created by Muhammad Abdul Ghani on 11/01/24.
//

import Foundation

struct LoginResponse: Codable {
    let code: String
    let message: String
    let data: LoginDataResponse
}

struct LoginDataResponse: Codable {
    let id: Int
    let token: String
}
