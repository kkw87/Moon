//
//  AccountCredentialsVerifier.swift
//  Moon
//
//  Created by Kevin Wang on 3/3/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation
import Firebase

class AccountCredentialsVerifier : CredentialsVerifier {
    
    private let authenticator : CredentialsVerifier
    
    init(authenticator : CredentialsVerifier = Auth.auth()) {
        self.authenticator = authenticator
    }
    
    func checkEmailForValidity(emailToCheck : String, withHandler completionHandler: @escaping Completion) {
  
        authenticator.checkEmailForValidity(emailToCheck: emailToCheck) { (returnedStrings, error) in
            
                guard error == nil else {
                    completionHandler(nil, error!)
                    return
                }
                
                if returnedStrings != nil {
                    completionHandler(returnedStrings!, nil)
                } else {
                    completionHandler(nil, nil)
                }
        }
    }
    
}

