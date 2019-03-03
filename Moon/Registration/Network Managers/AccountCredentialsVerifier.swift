//
//  AccountCredentialsVerifier.swift
//  Moon
//
//  Created by Kevin Wang on 3/3/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation
import Firebase

class AccountCredentialsVerifier {
    
    typealias Completion = (Bool, Error?) -> Void
    
    func checkEmailForValidity(emailToCheck : String, withHandler completionHandler: @escaping Completion) {
  
        Auth.auth().fetchProviders(forEmail: emailToCheck) { (returnedStrings, error) in
            
            guard error == nil else {
                completionHandler(false, error!)
                return
            }
            
            if returnedStrings == nil {
                completionHandler(false, nil)
            } else {
                completionHandler(true, nil)
            }
        }
    }
    
}
