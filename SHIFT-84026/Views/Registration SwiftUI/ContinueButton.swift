//
//  OnboardingButton.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 23.06.2025.
//

import SwiftUI

struct ContinueButton: View {
    @ObservedObject var viewModel: RegistrationViewModel
    
    var body: some View {
        Button {
            viewModel.register()
        } label: {
            Text("Зарегистрироваться")
                .foregroundStyle(.white)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .fill(LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .overlay(
                            Capsule()
                                .stroke(.secondary, lineWidth: 1)
                        )
                )
        }
        .opacity(!viewModel.isFormValid ? 0.5 : 1)
        .disabled(!viewModel.isFormValid)
        .onTapGesture {
            viewModel.continueButtonTapped = true
        }
    }
}


#Preview {
    ContinueButton(viewModel: RegistrationViewModel(sessionService: SessionService()))
        .padding()
}
