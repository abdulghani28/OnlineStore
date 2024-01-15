//
//  VariantView.swift
//  DataUtamaTest
//
//  Created by Muhammad Abdul Ghani on 12/01/24.
//

import SwiftUI
import PhotosUI

struct AddVariantView: View {
    @StateObject private var photoViewModel = PhotoPickerViewModel()
    @ObservedObject var variantViewModel = VariantViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            if let image = photoViewModel.selectedImage {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .background(Color.white)
                        .shadow(radius: 10)
                }
                .onAppear {
                    if let imageData = image.jpegData(compressionQuality: 0.5) {
                        let base64String = "data:image/jpeg;base64," + imageData.base64EncodedString()
                        variantViewModel.variantImage = base64String
                    } else {
                        print("Failed to get JPEG representation of the image.")
                    }
                }
            } else {
                PhotosPicker(selection: $photoViewModel.imageSelection, matching: .images) {
                    ZStack {
                        Image("Component 7_1")
                    }
                    .frame(width: 200, height: 200)
                    .background(.white)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.top, 50)
                }
            }
            
            InputView(text: $variantViewModel.variantName, title: "Variant Name", placeholder: "Variant Product Name")
                .padding(.top)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Harga")
                    .foregroundStyle(Color(.darkGray))
                    .fontWeight(.semibold)
                    .font(.footnote)
                
                HStack {
                    Text("Rp")
                        .foregroundStyle(Color.gray)
                        .fontWeight(.semibold)
                        .font(.footnote)
                    TextField("0", text: $variantViewModel.variantPrice)
                        .keyboardType(.numberPad)
                        .font(.system(size: 14))
                        .textInputAutocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Stock")
                    .foregroundStyle(Color(.darkGray))
                    .fontWeight(.semibold)
                    .font(.footnote)
                
                TextField("0", text: $variantViewModel.variantStock)
                    .keyboardType(.numberPad)
                    .font(.system(size: 14))
                    .textInputAutocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
        }
        .padding()
        
        Spacer()
        
        Button(action: {
            variantViewModel.addVariant()
            dismiss()
        }) {
            Text("Add")
                .frame(maxWidth: .infinity)
                .bold()
                .frame(height: 60)
                .background(Color.blue)
                .foregroundColor(.white)
        }
        .padding(.vertical)

        
    }
}

#Preview {
    AddVariantView()
}
