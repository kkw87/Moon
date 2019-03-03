//
//  UserDefaults.swift
//  Moon
//
//  Created by Kevin Wang on 2/27/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import Foundation

struct UserDefaultKeys {
    static let EmailLogin = "UserLogin"
    static let Userpassword = "UserPassword"
}

extension UserDefaults {
    
    var userCredentials : (login : String, password : String)? {
        get {
            
            if let userLogin = UserDefaults.standard.value(forKey: UserDefaultKeys.EmailLogin) as? String, let userPassword = UserDefaults.standard.value(forKey: UserDefaultKeys.Userpassword) as? String {
                return (userLogin, userPassword)
            }
            
            return nil
            
        } set {
            UserDefaults.standard.setValue(newValue?.login, forKey: UserDefaultKeys.EmailLogin)
            UserDefaults.standard.setValue(newValue?.password, forKey: UserDefaultKeys.Userpassword)
        }
    }
    
}
