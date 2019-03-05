//
//  LoginTest.swift
//  MoonTests
//
//  Created by Kevin Wang on 3/2/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import XCTest
@testable import Moon

class LoginTest: XCTestCase {

    var loginVC : LoginViewController!
    
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        loginVC = (storyBoard.instantiateViewController(withIdentifier: "Login") as! LoginViewController)
    }

    override func tearDown() {
        loginVC = nil
        super.tearDown()
    }

    func testValidInput() {
        let validLoginName = "tester123@gmail.com"
        let validLoginPassword = "1234567"
        
        let inputResults = loginVC.validInput(loginEmail: validLoginName, loginPassword: validLoginPassword)
        
        XCTAssert(inputResults, "A valid user name and password is being rejected")
    }

    func testInvalidInput() {
        let invalidLoginName = "tester123"
        let invalidPassword = "123"
        
        let emptyLoginName = ""
        let emptyPassword = ""
        
        XCTAssertFalse(loginVC.validInput(loginEmail: invalidLoginName, loginPassword: invalidPassword), "User name not in email format is being accepted and a password less than seven characters is being accepted")
        XCTAssertFalse(loginVC.validInput(loginEmail: emptyLoginName , loginPassword: emptyPassword), "An empty login name and empty password is being accepted")
    }

}
