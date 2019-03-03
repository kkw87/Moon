//
//  MoonDatabase.swift
//  Moon
//
//  Created by Kevin Wang on 1/28/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

// MARK: - Root references
struct MoonDatabase {
    static let UserRootReference = Database.database().reference().child("users")
    static let MessageRootReference = Database.database().reference().child("messages")
    static let RelationshipRootReference = Database.database().reference().child("relationship")
}

struct MoonDatabaseStorage {
        static let UserProfileImageRootReference = Storage.storage().reference().child("profile_images") 
}

// MARK: - User Structure
struct UserKeys {
        static let UserName = "user_name"
        static let UserDisplayName = "display_name"
        static let UserRelationship = "relationship"
}

// MARK: - Firebase Auth Error Handling
extension AuthErrorCode {
    var errorMessage : String {
        switch self {
        case .emailAlreadyInUse : return "The email address you entered is already in use"
        case .userNotFound : return "Your account was not found"
        case .userDisabled : return "Your account has been disabled"
        case .invalidEmail, .invalidSender, .invalidRecipientEmail : return "Please enter a valid email"
        case .networkError : return "Network error. Please try again"
        case .weakPassword : return "Your password must be longer than 6 characters"
        case .wrongPassword : return "The password you entered is incorrect"
        default : return "Unknown error occured. Please try again."
        }
    }
}

