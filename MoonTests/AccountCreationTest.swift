//
//  AccountCreationTest.swift
//  MoonTests
//
//  Created by Kevin Wang on 3/1/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import XCTest
@testable import Moon

class AccountCreationTest: XCTestCase {
    
    var accountCreator : AccountCreator!

    override func setUp() {
        super.setUp()
        accountCreator = AccountCreator()
    }

    override func tearDown() {
        accountCreator = nil
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}