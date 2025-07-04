//
//  Validators.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 01.07.2025.
//

import Foundation


struct Validators {
    
    static func isValidName(_ name: String) -> Bool {
        guard name.count >= 2 else { return false }
        
        let pattern = "^[a-zA-Zа-яА-Я]+$"
        return name.range(of: pattern, options: .regularExpression) != nil
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8 &&
               password.rangeOfCharacter(from: .decimalDigits) != nil &&
               password.rangeOfCharacter(from: .uppercaseLetters) != nil
    }
    
    static func passwordsMatch(_ password: String, _ confirmPassword: String) -> Bool {
        return password == confirmPassword
    }
    
    static func isValidBirthDate(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let now = Date()

        guard calendar.date(byAdding: .year, value: -100, to: now) != nil,
              calendar.date(byAdding: .year, value: -18, to: now) != nil,
              let age = calendar.dateComponents([.year], from: date, to: now).year
        else { return false }
        
        return age >= 18 && age <= 100
    }
}
