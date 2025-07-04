//
//  RegistrationError.swift
//  FakeStore
//
//  Created by Антон Разгуляев on 01.07.2025.
//

import SwiftUI


final class RegistrationViewModel: ObservableObject {
    @AppStorage("nameField") var nameField = ""
    @AppStorage("lastNameField") var lastNameField = ""
    private let birthDateKey = "birthDate"
    @Published var birthDate: Date {
        didSet { Saver.save(birthDate, forKey: birthDateKey) }
    }
    @AppStorage("passwordField") var passwordField = ""
    @AppStorage("confirmPasswordField") var confirmPasswordField = ""
    @Published var continueButtonTapped: Bool = false

    private var sessionService: SessionServiceProtocol
    
    init(sessionService: SessionServiceProtocol) {
        self.sessionService = sessionService
        birthDate = Saver.load(forKey: birthDateKey, as: Date.self) ?? Date()
    }
    
    var isFormValid: Bool {
        Validators.isValidName(nameField) &&
        Validators.isValidName(lastNameField) &&
        Validators.isValidBirthDate(birthDate) &&
        Validators.isValidPassword(passwordField) &&
        Validators.passwordsMatch(passwordField, confirmPasswordField)
    }
    
    func register() {
        if isFormValid {
            let user = User(firstName: nameField, lastName: lastNameField, birthDate: birthDate, password: passwordField)
            sessionService.registerUser(user)
        }
    }
}
