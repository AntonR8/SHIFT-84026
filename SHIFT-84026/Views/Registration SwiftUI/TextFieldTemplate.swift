//
//  TextFieldTemplate.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 02.07.2025.
//

import SwiftUI

struct TextFieldTemplate: View {
    
    let title: String
    let isSecure: Bool
    let template: String
    let icon: String
    var isFocused: Bool
    @Binding var currentTextFieldText: String
    var nextTextField: () -> Void
    let isValid: Bool
    let errorMessage: String
    @Binding var continueButtonTapped: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.callout)
                .foregroundStyle(isFocused ? Color.yellow : .primary)
                .padding(.leading, 32)
            Group{
                if !isSecure {
                    TextField(template, text: $currentTextFieldText)
                } else {
                    SecureField(template, text: $currentTextFieldText)
                }
                
            }
//            .textContentType(isSecure ? .password : .givenName)
            .disableAutocorrection(isSecure ? true : false)
            .textInputAutocapitalization(isSecure ? .never : .words)
            .keyboardType(.default)
            .onSubmit {
                nextTextField()
            }
            .submitLabel(.next)
            .padding(12)
            .padding(.leading, 30)
            .background(.secondary.opacity(0.1))
            .clipShape(Capsule())
            .overlay {
                Capsule()
                    .stroke(isFocused ? Color.yellow : Color.secondary,
                            lineWidth: isFocused ? 1 : 0.3)
            }
            .overlay {
                HStack{
                    Image(systemName: icon)
                    Spacer()
                    if !currentTextFieldText.isEmpty {
                        Button(action: {currentTextFieldText = ""}) {
                            Image(systemName: "xmark")
                                .foregroundStyle(.gray)
                                .font(.footnote)
                                .padding(6)
                                .overlay {
                                    Capsule()
                                        .stroke(Color.gray, lineWidth: 1)
                                }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(1)
            if !isValid {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(continueButtonTapped ? .red : .secondary)
                    .padding(.leading, 30)
            }
        }
        .padding(.bottom)
        
    }
}

#Preview {
    TextFieldTemplate(title: "email", isSecure: true, template: "Иван", icon: "person", isFocused: false, currentTextFieldText: .constant(""), nextTextField: {}, isValid: false, errorMessage: "sdfsf", continueButtonTapped: .constant(true))
    
}
