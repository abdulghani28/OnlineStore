//
//  InputView.swift
//  DataUtamaTest
//
//  Created by Muhammad Abdul Ghani on 11/01/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
               SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email address", placeholder: "email@example.com")
}
