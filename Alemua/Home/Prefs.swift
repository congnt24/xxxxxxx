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
    
    
}
