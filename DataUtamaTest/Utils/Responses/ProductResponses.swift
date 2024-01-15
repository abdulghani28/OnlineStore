//
//  ProductResponses.swift
//  DataUtamaTest
//
//  Created by Muhammad Abdul Ghani on 12/01/24.
//

import Foundation

struct ProductResponse: Codable {
    let code: String
    let message: String
    let data: ProductDataResponse
}

struct ProductDataResponse: Codable {
    let items: [ProductModel]
    let per_page: Int
    let total: Int
    let last_page: String
}
