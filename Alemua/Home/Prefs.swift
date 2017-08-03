//
//  Prefs.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/29/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation

class Prefs {
    class var isUserLogged: Bool {
        get {
            return UserDefaults.standard.bool(forKey: AppConstant.LOGGED_KEY)
        }
        set(logged){
            UserDefaults.standard.set(logged, forKey: AppConstant.LOGGED_KEY)
            UserDefaults.standard.synchronize()
        }
    }
    
    class var apiToken: String? {
        get {
            return UserDefaults.standard.string(forKey: AppConstant.API_TOKEN)
        }
        set(token){
            UserDefaults.standard.set(token, forKey: AppConstant.API_TOKEN)
            UserDefaults.standard.synchronize()
        }
    }
    
}
