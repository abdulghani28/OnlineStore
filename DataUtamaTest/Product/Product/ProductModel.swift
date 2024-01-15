//
//  ProductModel.swift
//  DataUtamaTest
//
//  Created by Muhammad Abdul Ghani on 12/01/24.
//

import Foundation

struct ProductModel: Identifiable, Codable {
    var id: Int
    var title: String
    var description: String
    var variants: [VariantModel]
}
