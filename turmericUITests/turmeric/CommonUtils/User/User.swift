//
//  User.swift
//  turmeric
//
//  Created by kavya sriram on 8/26/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import Foundation

class User {
    
    var name : String //
    var username :String //
    var password :String //
    var email :  String //

    
    init(name : String, username: String, password: String, email: String) {
        self.name = name
        self.username = username
        self.password = password
        self.email = email

    }
    
    func getName() -> String {
        return name;
    }
    
    func getUsername() -> String {
        return username;
    }
    
    func getPassword() -> String {
        return password;
    }
    
    func getEmail() -> String {
        return email;
    }
    
    

}


