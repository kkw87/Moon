//
//  AccountCreationPhotoDetailsTest.swift
//  MoonTests
//
//  Created by Kevin Wang on 2/25/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import XCTest
@testable import Moon

var accountCreationPhotoDetailsVC : AccountCreationPictureSelectionViewController!

class AccountCreationPhotoDetailsTest: XCTestCase {

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        accountCreationPhotoDetailsVC = (storyboard.instantiateViewController(withIdentifier: "Account Creation Photo") as! AccountCreationPictureSelectionViewController)
        
        
    }

    override func tearDown() {
        accountCreationPhotoDetailsVC = nil
        super.tearDown()
    }
    
    func testValidUserName() {
        
        let validDisplayName = "Tester Account"
        let invalidDisplayName = ""
        let nilDisplayName : String? = nil
        accountCreationPhotoDetailsVC.userProfileImage = UIImage()
        
        let validResults = accountCreationPhotoDetailsVC.checkForValidInput(userName: validDisplayName)
        
        let invalidResults = accountCreationPhotoDetailsVC.checkForValidInput(userName: invalidDisplayName)
        
        XCTAssert(validResults, "Account creation is rejecting a valid user display name")
        
        XCTAssertFalse(invalidResults, "Account creation is accepting a blank display name")
        
        XCTAssertFalse(accountCreationPhotoDetailsVC.checkForValidInput(userName: nil), "Account creation accepts a nil value")
    }
    
    func testUserImageSelection() {
        
            let testImage = UIImage()
        accountCreationPhotoDetailsVC.imagePickerController(accountCreationPhotoDetailsVC.photoVC, didFinishPickingMediaWithInfo: [UIImagePickerController.InfoKey.originalImage : testImage])
        
        
            XCTAssert(accountCreationPhotoDetailsVC.userProfileImage == testImage, "The user selected image is not saved in the userProfileImage variable")
    }
}
