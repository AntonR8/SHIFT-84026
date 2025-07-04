//
//  AppTests.swift
//  AppTests
//
//  Created by Антон Разгуляев on 03.07.2025.
//

import XCTest
@testable import SHIFT_84026

class ValidatorsTests: XCTestCase {
    
    func testIsValidName() {
        XCTAssertTrue(Validators.isValidName("John"))
        XCTAssertTrue(Validators.isValidName("Мария"))
        XCTAssertFalse(Validators.isValidName("J"))
        XCTAssertFalse(Validators.isValidName("John1"))
    }
    
    func testIsValidPassword() {
        XCTAssertTrue(Validators.isValidPassword("Strong123"))
        XCTAssertFalse(Validators.isValidPassword("weak"))
        XCTAssertFalse(Validators.isValidPassword("weakpassword"))
        XCTAssertFalse(Validators.isValidPassword("WEAKPASSWORD"))
        XCTAssertFalse(Validators.isValidPassword("12345678"))
    }
    
    func testIsValidBirthDate() {
        let calendar = Calendar.current
        let now = Date()
        
        let validDate = calendar.date(byAdding: .year, value: -18, to: now)!
        XCTAssertTrue(Validators.isValidBirthDate(validDate))
        
        let invalidDate = calendar.date(byAdding: .year, value: -17, to: now)!
        XCTAssertFalse(Validators.isValidBirthDate(invalidDate))
        
        let tooOldDate = calendar.date(byAdding: .year, value: -101, to: now)!
        XCTAssertFalse(Validators.isValidBirthDate(tooOldDate))
    }
}

class SessionServiceTests: XCTestCase {
    var sessionService: SessionService!
    
    override func setUp() {
        super.setUp()
        sessionService = SessionService()
        sessionService.clearSession() // Clear any previous data
    }
    
    func testRegisterUser() {
        let user = User(firstName: "Test", lastName: "User", birthDate: Date(), password: "Test1234")
        sessionService.registerUser(user)
        
        XCTAssertTrue(sessionService.userIsRegistered)
        XCTAssertNotNil(sessionService.currentUser)
        XCTAssertEqual(sessionService.currentUser?.firstName, "Test")
    }
    
    func testClearSession() {
        let user = User(firstName: "Test", lastName: "User", birthDate: Date(), password: "Test1234")
        sessionService.registerUser(user)
        sessionService.clearSession()
        
        XCTAssertFalse(sessionService.userIsRegistered)
        XCTAssertNil(sessionService.currentUser)
    }
}
