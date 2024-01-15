//
//  LoginView.swift
//  DataUtamaTest
//
//  Created by Muhammad Abdul Ghani on 11/01/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("Login")
                        .bold()
                        .foregroundStyle(.blue)
                        .font(.largeTitle)
                        .padding(.bottom, 50)
                    
                    VStack {
                        InputView(text: $viewModel.email, title: "Email", placeholder: "Email")
                            .padding(.bottom)
                        
                        InputView(text: $viewModel.password, title: "Password", placeholder: "*****", isSecureField: true)
                    }
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    Task {
                        await viewModel.login()
                    }
                }) {
                    Text("LOGIN")
                        .frame(maxWidth: .infinity)
                        .bold()
                        .frame(height: 60)
                        .background(Color.blue)
                        .foregroundColor(.white)
                }
                .padding(.vertical)
                
                NavigationLink(destination: ListProdukView(), isActive: $viewModel.isLogin) {
                    EmptyView()
                }
                .hidden()
            }
        }
    }
}

#Preview {
    LoginView()
}
