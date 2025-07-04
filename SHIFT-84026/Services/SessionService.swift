//
//  SessionService.swift
//  SHIFT-84026
//
//  Created by Антон Разгуляев on 01.07.2025.
//

import Foundation
import SwiftUI


class SessionService: ObservableObject, SessionServiceProtocol {
    private let userKey = "currentUser"
    @AppStorage("userIsRegistered") var userIsRegistered: Bool = false
    @Published var currentUser: User? {
        didSet { Saver.save(currentUser, forKey: userKey) }
    }
    
    init() {
        currentUser = Saver.load(forKey: userKey, as: User.self)
    }
    
    
    
    func registerUser(_ user: User) {
        userIsRegistered = true
        currentUser = user
    }
    
    func clearSession() {
        userIsRegistered = false
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: userKey)
    }
}
