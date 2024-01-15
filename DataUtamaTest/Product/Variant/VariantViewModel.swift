//
//  VariantViewModel.swift
//  DataUtamaTest
//
//  Created by Muhammad Abdul Ghani on 13/01/24.
//

import Foundation

class VariantViewModel: ObservableObject {
    @Published var variantPrice = ""
    @Published var variantStock = ""
    @Published var variantName = ""
    @Published var variantImage = ""
    @Published var variants: [VariantModel] = []
    private let maxVariant = 3
    
    var currentVariantCount: Int {
        return variants.count
    }
    
    func addVariant() {
        if currentVariantCount < maxVariant {
            let newVariant = VariantModel(name: variantName, price: Int(variantPrice) ?? 0, stock: Int(variantStock) ?? 0, image: variantImage)
            variants.append(newVariant)
            print(variants)
            print("variants")
        }
    }
}
