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
    
    func testValidInput() {
        
        let validDisplayName = "Tester Account"
        accountCreationPhotoDetailsVC.userProfileImage = UIImage()

        let validResults = accountCreationPhotoDetailsVC.checkForValidInput(userName: validDisplayName)
        
        
        XCTAssert(validResults, "Account creation is rejecting a valid user display name")
        XCTAssert(accountCreationPhotoDetailsVC.displayNameErrorLabelIsHidden, "Display name error label is still visible")
        XCTAssert(accountCreationPhotoDetailsVC.profilePictureErrorLabelIsHidden, "Profile picture error label is still visible")

    }
    
    func testInvalidInput() {
        
        let invalidDisplayName = ""
        accountCreationPhotoDetailsVC.userProfileImage = UIImage()
        
        let invalidResults = accountCreationPhotoDetailsVC.checkForValidInput(userName: invalidDisplayName)
        
        XCTAssertFalse(invalidResults, "Account creation is accepting a blank display name")
        
    }
    
    func testUserImageSelection() {
        
        let testImage = UIImage()
        accountCreationPhotoDetailsVC.imagePickerController(accountCreationPhotoDetailsVC.photoVC, didFinishPickingMediaWithInfo: [UIImagePickerController.InfoKey.originalImage : testImage])
        
        
        XCTAssert(accountCreationPhotoDetailsVC.userProfileImage == testImage, "The user selected image is not saved in the userProfileImage variable")
    }
}
