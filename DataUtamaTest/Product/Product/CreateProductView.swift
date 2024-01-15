//
//  CreateProductView.swift
//  DataUtamaTest
//
//  Created by Muhammad Abdul Ghani on 11/01/24.
//

import SwiftUI

struct CreateProductView: View {
    @StateObject var viewModel = ProductViewModel(variantViewModel: VariantViewModel())
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                InputView(text: $viewModel.title, title: "Name", placeholder: "Product Name")
                
                InputView(text: $viewModel.description, title: "Description", placeholder: "description product")
                
                Text("Variant Product")
                    .foregroundStyle(Color(.darkGray))
                    .fontWeight(.semibold)
                    .font(.footnote)
                
                NavigationLink {
                    AddVariantView(variantViewModel: viewModel.variantViewModel)
                } label: {
                    customVarianButton(title: "Add Variant 1")
                }

                NavigationLink {
                    
                } label: {
                    customVarianButton(title: "Add Variant 2")
                }
                
                NavigationLink {
                    
                } label: {
                    customVarianButton(title: "Add Variant 3")
                }
                
            }
            .padding()
            
            Spacer()
            Button(action: {
                viewModel.createProduct()
                dismiss()
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .bold()
                    .frame(height: 60)
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
            .padding(.vertical)
        }
    }
}

struct customVarianButton: View {
    @State var title: String
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
            .stroke(.blue)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .overlay(content: {
                Text(title)
                    .foregroundColor(.blue)
                    .bold()
                    .font(.caption)
            })
    }
}

#Preview {
    CreateProductView()
}
