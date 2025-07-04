//
//  ContentView.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 01.07.2025.
//

import SwiftUI


enum FocusedField {
    case name
    case secondName
    case password
    case confirmPassword
}



struct RegistrationView: View {    
    @FocusState private var focusedField: FocusedField?
    @StateObject private var viewModel: RegistrationViewModel
    
    init(sessionService: SessionService) {
        _viewModel = StateObject(
            wrappedValue: RegistrationViewModel(sessionService: sessionService)
        )
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        name
                        secondName
                        date
                        password
                        confirmPassword
                        button
                    }
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        if (focusedField != nil) {
                            focusedField = nil
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Регистрация")
            .navigationBarTitleDisplayMode(.inline)
            .hideKeyboardOnScroll()
        }
    }
}

#Preview {
    RegistrationView(sessionService: SessionService())
}


extension RegistrationView {
    var name: some View {
        TextFieldTemplate(
            title: "Имя",
            isSecure: false,
            template: "Иван",
            icon: "person",
            isFocused: focusedField == .name,
            currentTextFieldText: $viewModel.nameField,
            nextTextField: { focusedField = .secondName },
            isValid: Validators.isValidName(viewModel.nameField) && !viewModel.nameField.isEmpty,
            errorMessage: RegistrationError.invalidFirstName.errorDescription,
            continueButtonTapped: $viewModel.continueButtonTapped
        )
        .focused($focusedField, equals: .name)
    }
    
    var secondName: some View {
        TextFieldTemplate(
            title: "Фамилимя",
            isSecure: false,
            template: "Петров",
            icon: "person.fill",
            isFocused: focusedField == .secondName,
            currentTextFieldText: $viewModel.lastNameField,
            nextTextField: { focusedField = nil },
            isValid: Validators.isValidName(viewModel.lastNameField) && !viewModel.lastNameField.isEmpty,
            errorMessage: RegistrationError.invalidLastName.errorDescription,
            continueButtonTapped: $viewModel.continueButtonTapped
        )
        .focused($focusedField, equals: .secondName)
    }
    
    var date: some View {
        DatePickerField(
            title: "Дата рождения",
            date: $viewModel.birthDate,
            isValid: Validators.isValidBirthDate(viewModel.birthDate),
            errorMessage: RegistrationError.invalidBirthDate.errorDescription,
            continueButtonTapped: $viewModel.continueButtonTapped
        )
    }
    
    
    var password: some View {
        TextFieldTemplate(
            title: "Пароль",
            isSecure: true,
            template: "********",
            icon: "lock",
            isFocused: focusedField == .password,
            currentTextFieldText: $viewModel.passwordField,
            nextTextField: { focusedField = .confirmPassword },
            isValid: Validators.isValidPassword(viewModel.passwordField) && !viewModel.passwordField.isEmpty,
            errorMessage: RegistrationError.invalidPassword.errorDescription,
            continueButtonTapped: $viewModel.continueButtonTapped
        )
        .focused($focusedField, equals: .password)
    }
    
    var confirmPassword: some View {
        TextFieldTemplate(
            title: "Подтвердите пароль",
            isSecure: true,
            template: "********",
            icon: "lock.fill",
            isFocused: focusedField == .confirmPassword,
            currentTextFieldText: $viewModel.confirmPasswordField,
            nextTextField: {
                focusedField = nil
                viewModel.register()
            },
            isValid: Validators.passwordsMatch(viewModel.passwordField, viewModel.confirmPasswordField),
            errorMessage: RegistrationError.passwordsDontMatch.errorDescription,
            continueButtonTapped: $viewModel.continueButtonTapped
        )
        .focused($focusedField, equals: .confirmPassword)
    }
    
    var button: some View {
        ContinueButton(viewModel: viewModel)
            .padding(32)
    }
    
}
