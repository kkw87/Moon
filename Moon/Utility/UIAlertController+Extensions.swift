//
//  UIAlertController+Extensions.swift
//  Moon
//
//  Created by Kevin Wang on 2/28/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension UIAlertController {
    
    struct MessageText {
        static let DefaultTitleText = "Oops! There seems to be a problem."
        static let DefaultErrorText = "Unknown error occured. Please try again."
        static let DefaultMessageText = "The operation could not be completed. Please try again."
        static let DefaultContinueButtonText = "Continue"
    }
    
    convenience init(title : String = MessageText.DefaultTitleText, message : String = MessageText.DefaultMessageText, continueButton : String = MessageText.DefaultContinueButtonText, tintColor : UIColor?) {
        
        self.init(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: continueButton, style: .default, handler: nil)
        self.addAction(confirmAction)
    }
    
    convenience init(title : String = MessageText.DefaultTitleText, error : Error, continueButton : String = MessageText.DefaultContinueButtonText) {
        var errorMessage = MessageText.DefaultErrorText
        
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            errorMessage = errorCode.errorMessage
        }
        
        self.init(title: title, message: errorMessage, preferredStyle: .alert)
        
        self.addAction(UIAlertAction(title: continueButton, style: .default, handler: nil))
    }
    
}
