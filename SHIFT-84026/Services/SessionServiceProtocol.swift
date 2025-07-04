//
//  SessionServiceProtocol.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 01.07.2025.
//

import Foundation


protocol SessionServiceProtocol {
    var currentUser: User? { get }
    func registerUser(_ user: User)
    func clearSession()
}


