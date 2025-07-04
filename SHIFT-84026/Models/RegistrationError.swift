//
//  RegistrationError 2.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 01.07.2025.
//

import Foundation


enum RegistrationError: LocalizedError {
    case invalidFirstName
    case invalidLastName
    case invalidBirthDate
    case invalidPassword
    case passwordsDontMatch
    
    var errorDescription: String {
        switch self {
        case .invalidFirstName:
            return "Имя должно содержать только буквы и быть не менее 2 символов"
        case .invalidLastName:
            return "Фамилия должна содержать только буквы и быть не менее 2 символов"
        case .invalidBirthDate:
            return "Вам должно быть не менее 18 лет"
        case .invalidPassword:
            return "Пароль должен содержать одну заглавную букву, одну цифру и быть не менее 8 символов"
        case .passwordsDontMatch:
            return "Пароли не совпадают"
        }
    }
}
