//
//  ContentView.swift
//  DataUtamaTest
//
//  Created by Muhammad Abdul Ghani on 11/01/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Spacer()
                
                Image("Component 4_1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 3/4)
                
                Spacer()
                
                
                VStack(spacing: 16) {
                    NavigationLink {
                        LoginView()
                    } label: {
                        CustomButton(title: "LOGIN")
                    }
                    
                    NavigationLink {
                        RegisterView()
                    } label: {
                        CustomButton(title: "REGISTER")
                    }
                    
                }
            }
            .padding(30)
        }
    }
}

struct CustomButton: View {
    let title: String

    var body: some View {
            Capsule()
                .fill(Color.blue)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .overlay(content: {
                    Text(title)
                        .foregroundColor(.white)
                        .bold()
                        .font(.headline)
                })
    }
}

#Preview {
    ContentView()
}
