//
//  Token.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation


struct Token {
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "Token")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Token")
            UserDefaults.standard.synchronize()
        }
    }
    
    var isTokenExist: Bool {
        if let _ = token {
            return true
        }
        return false
    }
    
    func remove(){
        UserDefaults.standard.removeObject(forKey: "Token")
    }
}
