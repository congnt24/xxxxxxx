//
//  Prefs.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/29/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation



func isNotEnoughInfo() -> Bool {
    if Prefs.phoneNumber == "" || Prefs.userName == "" || Prefs.address == "" || Prefs.email == "" {
        return true
    }
    return false
}

class Prefs {
    static let isTest = false
    
    class var firebaseToken: String {
        get {
            return UserDefaults.standard.string(forKey: "firebaseToken") ?? ""
        }
        set(id) {
            UserDefaults.standard.set(id, forKey: "firebaseToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    class var isUserLogged: Bool {
        get {
            return UserDefaults.standard.bool(forKey: AppConstant.LOGGED_KEY)
        }
        set(logged) {
            UserDefaults.standard.set(logged, forKey: AppConstant.LOGGED_KEY)
            UserDefaults.standard.synchronize()
        }
    }
    class var userId: Int {
        get {
            if Prefs.isTest {
                return 3
            }
            return UserDefaults.standard.integer(forKey: "userId")
        }
        set(id) {
            UserDefaults.standard.set(id, forKey: "userId")
            UserDefaults.standard.synchronize()
        }
    }
    
    class var userName: String {
        get {
            return UserDefaults.standard.string(forKey: "userName") ?? ""
        }
        set(token) {
            UserDefaults.standard.set(token, forKey: "userName")
            UserDefaults.standard.synchronize()
        }
    }
    class var email: String {
        get {
            return UserDefaults.standard.string(forKey: "email") ?? ""
        }
        set(token) {
            UserDefaults.standard.set(token, forKey: "email")
            UserDefaults.standard.synchronize()
        }
    }
    class var address: String {
        get {
            return UserDefaults.standard.string(forKey: "address") ?? ""
        }
        set(token) {
            UserDefaults.standard.set(token, forKey: "address")
            UserDefaults.standard.synchronize()
        }
    }
    class var desc: String {
        get {
            return UserDefaults.standard.string(forKey: "desc") ?? ""
        }
        set(token) {
            UserDefaults.standard.set(token, forKey: "desc")
            UserDefaults.standard.synchronize()
        }
    }
    
    class var apiTokenShipper: String {
        get {
            if Prefs.isTest {
                return "gduO4eJFqR9eUnHhdKiEADIyhOBhEh6RF6qQZ5oNWhF9ySLeE4MLlGM5L4Nd"
            }
            return UserDefaults.standard.string(forKey: AppConstant.API_TOKEN) ?? "0"
        }
        set(token) {
            UserDefaults.standard.set(token, forKey: AppConstant.API_TOKEN)
            UserDefaults.standard.synchronize()
        }
    }



    class var userIdClient: Int {
        get {
            if Prefs.isTest {
                return 2
            }
            return UserDefaults.standard.integer(forKey: "userId")
        }
        set(id) {
            UserDefaults.standard.set(id, forKey: "userId")
            UserDefaults.standard.synchronize()
        }
    }
    
    class var apiToken: String {
        get {
            if Prefs.isTest {
                return "4fIVqGZPGQQakv7FBlyzUs671jzerg422UZrP2t4trl761Tekdngg6DSZoe8"
            }
            return UserDefaults.standard.string(forKey: AppConstant.API_TOKEN) ?? "0"
        }
        set(token) {
            UserDefaults.standard.set(token, forKey: AppConstant.API_TOKEN)
            UserDefaults.standard.synchronize()
        }
    }
    class var phoneNumber: String {
        get {
            return UserDefaults.standard.string(forKey: "phone") ?? ""
        }
        set(token) {
            UserDefaults.standard.set(token, forKey: "phone")
            UserDefaults.standard.synchronize()
        }
    }
    class var photo: String {
        get {
            return UserDefaults.standard.string(forKey: "photo") ?? ""
        }
        set(token) {
            UserDefaults.standard.set(token, forKey: "photo")
            UserDefaults.standard.synchronize()
        }
    }

}
