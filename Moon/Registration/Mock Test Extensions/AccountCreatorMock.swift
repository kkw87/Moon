//
//  AccountCreatorMock.swift
//  Moon
//
//  Created by Kevin Wang on 3/4/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation
import Firebase

//protocol AccountCreation {
//    
//    typealias Completion = (AuthDataResult?, Error) -> Void
//    
//      func createUser(withUser : AccountCreationModel, withCompletionHandler completionHandler: @escaping Completion)
//    
//      func uploadUserInformation(withUID : String, andUserInformation user : AccountCreationModel, withCompletionHandler completionHandler: @escaping Completion)
//}
//
//class AccountCreatorMock : AccountCreation {
//    
//    func createUser(withUser: AccountCreationModel, withCompletionHandler completionHandler: @escaping Completion) {
//        <#code#>
//    }
//    
//    func uploadUserInformation(withUID: String, andUserInformation user: AccountCreationModel, withCompletionHandler completionHandler: @escaping Completion) {
//        <#code#>
//    }
//    
//    
//}
//
//extension StorageReference : AccountCreation {
//    
//}
//
//extension Auth : AccountCreation {
//    
//}

//Storagereference
//Auth



//class AccountCreator {
//
//    // MARK: - Constants
//    struct Constants {
//        //The amount used for compressing the user profile image before uploading it to firebase
//        static let ImageCompressionAmount : CGFloat = 0.6
//    }
//
//    typealias Completion = (Bool, Error?) -> Void
//
//
//    func createUser(withUser : AccountCreationModel, withCompletionHandler completionHandler: @escaping Completion) {
//
//        let userInformation = withUser
//
//        Auth.auth().createUser(withEmail: userInformation.emailAddress, password: userInformation.password) {(result, error) in
//
//            guard error == nil else {
//                completionHandler(false, error)
//                return
//            }
//
//            guard let newUser = result?.user else {
//                completionHandler(false, nil)
//                return
//            }
//
//            self.uploadUserInformation(withUID: newUser.uid, andUserInformation: userInformation, withCompletionHandler: completionHandler)
//
//        }
//    }
//
//
//    private func uploadUserInformation(withUID : String, andUserInformation user : AccountCreationModel, withCompletionHandler completionHandler: @escaping Completion) {
//
//        if let userImage = user.userPhoto {
//
//            guard let userImageData = userImage.jpegData(compressionQuality: Constants.ImageCompressionAmount) else {
//                completionHandler(false, nil)
//                return
//            }
//
//            let metaData = StorageMetadata()
//            metaData.contentType = "img/jpeg"
//
//            MoonDatabaseStorage.UserProfileImageRootReference.child(withUID).putData(userImageData, metadata: metaData) { (storageMetaData, error) in
//
//                guard error == nil else {
//                    completionHandler(false, error!)
//                    return
//                }
//
//                completionHandler(true, nil)
//
//            }
//        }
//
//        MoonDatabase.UserRootReference.child(withUID).child(UserKeys.UserName).setValue(user.userName)
//        MoonDatabase.UserRootReference.child(withUID).child(UserKeys.UserDisplayName).setValue(user.userDisplayName)
//
//    }
//
//}
