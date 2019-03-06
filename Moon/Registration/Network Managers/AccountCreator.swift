//
//  AccountCreationViewModel.swift
//  Moon
//
//  Created by Kevin Wang on 1/28/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class AccountCreator {
    
    // MARK: - Init
    
    init(accountCreation : AccountCreation = AccountCreatorModel()) {
        self.accountCreator = accountCreation
    }
    
    // MARK: - Instance Variables
    private var accountCreator : AccountCreation
    
    // MARK: - User creation, Auth
    func createNewUserWith(userInformation : UserCreationModel, completionHandler completion : @escaping (Bool, Error?) -> Void) {
        return accountCreator.createUser(withUser: userInformation, withCompletionHandler: completion)
    }
}
