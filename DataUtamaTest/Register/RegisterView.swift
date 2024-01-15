//
//  RegisterView.swift
//  DataUtamaTest
//
//  Created by Muhammad Abdul Ghani on 11/01/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Register")
                    .bold()
                    .foregroundStyle(.blue)
                    .font(.largeTitle)
                    .padding(.bottom, 50)
                
                VStack {
                    InputView(text: $viewModel.name, title: "Name", placeholder: "Name")
                        .padding(.bottom)
                    
                    InputView(text: $viewModel.email, title: "Email", placeholder: "Email")
                        .padding(.bottom)
                    
                    InputView(text: $viewModel.password, title: "Password", placeholder: "*****", isSecureField: true)
                    
                    InputView(text: $viewModel.confirmedPassword, title: "Confirm Password", placeholder: "*****", isSecureField: true)
                        .onChange(of: viewModel.confirmedPassword) {
                            _ in viewModel.validatePasswordConfirmation()
                        }
                }
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                viewModel.register()
                dismiss()
            }) {
                Text("REGISTER")
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

#Preview {
    RegisterView()
}
