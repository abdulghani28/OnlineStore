//
//  ProductViewModel.swift
//  DataUtamaTest
//
//  Created by Muhammad Abdul Ghani on 11/01/24.
//

import Foundation
import SwiftUI
import PhotosUI
import _PhotosUI_SwiftUI

class ProductViewModel: ObservableObject {
    @Published var productList: [ProductModel] = []
    @Published var title = ""
    @Published var description = ""
    @ObservedObject var variantViewModel: VariantViewModel
    
    var currentVariantCount: Int {
        return variantViewModel.currentVariantCount
    }
    
    init(variantViewModel: VariantViewModel) {
        self.variantViewModel = variantViewModel
    }
        
    func createProduct() {
        Task {
            do {
                guard let url = URL(string: "https://tes-skill.datautama.com/test-skill/api/v1/product") else {
                    
                    throw URLError(.badURL)
                }

                let token = AuthService.shared.token
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue(token, forHTTPHeaderField: "Authorization")
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                                
                var variants: [[String: Any]] = []

                for variant in variantViewModel.variants {
                    let variantData: [String: Any] = [
                        "name": variant.name,
                        "image": variant.image,
                        "price": variant.price,
                        "stock": variant.stock
                    ]
                    variants.append(variantData)
                }

                let json: [String: Any] = [
                    "title": title,
                    "description": description,
                    "variants": variants
                ]
                print(json)
                print("token", token)
                
//                let json: [String: Any] = [
//                    "title": "ABC",
//                    "description": "abcccc",
//                    "variants": [
//                        [
//                            "name": "ABCCDDDD",
//                            "image": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAY",
//                            "price": 10000,
//                            "stock": 10
//                        ]
//                    ]
//                ]
                
                guard let httpBody = try? JSONSerialization.data(withJSONObject: json, options: []) else {
                    throw URLError(.badServerResponse)

                }
                
                request.httpBody = httpBody
                
                let result: ProductResponse = try await APIService.fetch(request: request)
                
                if result.code == "20000" {
                    print("Product success add")
                    await getProductList(token: token)
                } else {
                    print("Product failed")
                }
            } catch {
                print("Create product failed error: ", error.localizedDescription)
            }

        }
    }

    func getProductList(token: String) async {
            do {
                guard let url = URL(string: "https://tes-skill.datautama.com/test-skill/api/v1/product") else {
                    throw URLError(.badURL)
                }

                let token = AuthService.shared.token

                var request = URLRequest(url: url)
                request.addValue(token, forHTTPHeaderField: "Authorization")
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let result: ProductResponse = try await APIService.fetch(request: request)
                
                if result.code == "20000" {
                    print("Product: ", result.data.items)
                    productList = result.data.items
                    
                } else {
                    print("Get Product Failed")
                }
            } catch {
                print("Get product failed error: ", error.localizedDescription)
            }
    }
}

class PhotoPickerViewModel: ObservableObject {
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else {
            return
        }
        
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                    return
                }
            }
        }
    }
}
