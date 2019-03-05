//
//  AccountCredentialsVerifierTest.swift
//  MoonTests
//
//  Created by Kevin Wang on 3/3/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import XCTest
import Firebase
@testable import Moon

enum MockError : Error, CustomStringConvertible {
    case DefaultError
    
    var description: String {
        switch self {
        case .DefaultError:
            return "Mock Error"
            
        }
    }
}
    
    class AccountCredentialsVerifierTest: XCTestCase {
        
        var accountVerifier : AccountCredentialsVerifierMock!
        
        override func setUp() {
            super.setUp()
            accountVerifier = AccountCredentialsVerifierMock()
        }
        
        override func tearDown() {
            accountVerifier = nil
            super.tearDown()
        }
        
        func testValidError() {
            
            accountVerifier.error = MockError.DefaultError
            accountVerifier.returnedUsers = nil
            
            var tempError : Error? = nil
            var tempFoundUsers : [String]? = nil
            
            accountVerifier.checkEmailForValidity(emailToCheck: "") { (foundUsers, error) in
                tempError = error
                tempFoundUsers = nil
            }
            
            XCTAssert(tempFoundUsers == nil, "Returning users when it should be returning empty")
            XCTAssert(tempError != nil, "We have an error, but it is not being returned")
            
        }
        
        func testFoundExistingEmail() {
            accountVerifier.error = nil
            accountVerifier.returnedUsers = ["test"]
            
            var tempFoundUsers : [String]? = nil
            
            accountVerifier.checkEmailForValidity(emailToCheck: "") { (founderUsers, error) in
                tempFoundUsers = founderUsers
            }
            
            XCTAssert(tempFoundUsers != nil, "Email entered exists but it returning empty.")
        }
        
}

