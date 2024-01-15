//
//  ListProduk.swift
//  DataUtamaTest
//
//  Created by Muhammad Abdul Ghani on 11/01/24.
//

import SwiftUI

struct ListProdukView: View {
    @State var searchTerm = ""
    @StateObject var viewModel = ProductViewModel(variantViewModel: VariantViewModel())
    @StateObject var loginViewModel = LoginViewModel()
    var body: some View {
        
        Group {
            if !viewModel.productList.isEmpty {
                VStack {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(), GridItem()]) {
                            ForEach(viewModel.productList) { product in
                                VStack(alignment: .leading) {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 150, height: 150)
                                            .foregroundStyle(.white)
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                        if let firstVariant = product.variants.first {
                                            Image(firstVariant.image)
                                        }
                                    }
                                    Text(product.title)
                                    Text("Total Variant:  \(product.variants.count)")
                                }
                            }
                        }
                    }
                }
            } else {
                NavigationStack {
                    VStack {
                        Spacer()
                        NavigationLink {
                            CreateProductView()
                        } label: {
                            VStack {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Text("Add Product")
                            }
                            .bold()
                            .foregroundStyle(.blue)
                        }
                        Spacer()
                        
                        HStack {
                         Spacer()
                            Image("Component 12_1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                        }
                    }
                    .padding(.horizontal)

                }
            }
        }
        .task {
            await viewModel.getProductList(token: AuthService.shared.token)
        }
    }
}

#Preview {
    ListProdukView()
}
