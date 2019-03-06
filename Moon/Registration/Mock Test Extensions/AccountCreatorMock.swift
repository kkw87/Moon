//
//  AccountCreatorMock.swift
//  Moon
//
//  Created by Kevin Wang on 3/4/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation
import Firebase

protocol AccountCreation {
    
    typealias Completion = (Bool, Error?) -> Void
    
      func createUser(withUser : UserCreationModel, withCompletionHandler completionHandler: @escaping Completion)
    
      func uploadUserInformation(withUID : String, andUserInformation user : UserCreationModel, withCompletionHandler completionHandler: @escaping Completion)
    
}

class AccountCreatorMock : AccountCreation {
    
    var completed : Bool = true
    var error : Error?
    
    func createUser(withUser: UserCreationModel, withCompletionHandler completionHandler: @escaping Completion) {
        
        completionHandler(completed, error)
    }
    
    func uploadUserInformation(withUID: String, andUserInformation user: UserCreationModel, withCompletionHandler completionHandler: @escaping Completion) {
        completionHandler(completed, error)
    }
    
    
}
