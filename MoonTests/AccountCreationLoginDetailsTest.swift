//
//  AccountCreationLoginDetailsTest.swift
//  MoonTests
//
//  Created by Kevin Wang on 2/22/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import XCTest
@testable import Moon 

var accountCreationLoginDetailsVC : AccountCreationLoginDetailsViewController!

class AccountCreationLoginDetailsTest: XCTestCase {

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        accountCreationLoginDetailsVC = (storyboard.instantiateViewController(withIdentifier: "Account Creation Credentials") as! AccountCreationLoginDetailsViewController)
        accountCreationLoginDetailsVC.loadView()
    }

    override func tearDown() {
        accountCreationLoginDetailsVC = nil
        super.tearDown()
    }

    func testValidUserInput() {
        
        // Given
        
        //Valid user name must not be empty
        let validUserName = "Kevin"
        
        //Email has to contain a @domain.com and cannot be empty
        let validEmail = "testingAccount@gmail.com"
        
        //Password cannot be empty and must be longer than seven characters
        let validPassword = "testing12345"
        
        // When
        let validUserInput = accountCreationLoginDetailsVC.userEnteredInValidDetails(userName: validUserName, userEmail: validEmail, userPassword: validPassword)
        
        // Then
        XCTAssert(validUserInput, "Account creation is accepting not accepting valid user inputs for account creation")
    }
    
    func testInvalidUserInput() {
        
        //Given
        
        //Invalid user name is empty
        let invalidUserName = ""
     
        
        //Invalid email is formatted differently than name@domain.com or is empty
        let invalidEmailFormat = "testingAccoun"
        
        //Invalid password is less than seven characters
        let invalidPasswordLength = "t"
        // When
        
        let validUserInput = accountCreationLoginDetailsVC.userEnteredInValidDetails(userName: invalidUserName, userEmail: invalidEmailFormat, userPassword: invalidPasswordLength)

        // Then
        XCTAssert(!validUserInput, "Account creation is accepting invalid user inputs that contain invalid formats for account creation")
        
        //Invalid email is formatted differently than name@domain.com or is empty
        let blankEmail = ""
        accountCreationLoginDetailsVC.emailTextField.text = blankEmail
        
        //Invalid password is less than seven characters
        let blankPassword = ""
        accountCreationLoginDetailsVC.passwordTextField.text = blankPassword
        
        // When
        
        let invalidBlankUserInput = accountCreationLoginDetailsVC.userEnteredInValidDetails(userName: invalidUserName, userEmail: blankEmail, userPassword: blankPassword)
        // Then
        XCTAssert(!invalidBlankUserInput, "Account creation is accepting invalid user inputs with blank fields for account creation")
    }

}
