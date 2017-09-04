//
//  GoogleSigninHelper.swift
//  Alemua
//
//  Created by Cong Nguyen on 9/4/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import GoogleSignIn
import RxSwift

/**
 Handle login by google
 */
class GoogleSigninHelper: NSObject, GIDSignInDelegate {
    var onLoginEvent = PublishSubject<Any?>()
    private static var _instance: GoogleSigninHelper? = nil
    static func instance() -> GoogleSigninHelper {
        return _instance!
    }
    
    static func configure() {
        _instance = GoogleSigninHelper()
    }
    
    override init() {
        super.init()
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            onLoginEvent.onError(error)
            return
        }
        
        guard let authen = user.authentication else {
            onLoginEvent.onError(error)
            return
        }
        //        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        let credential = GoogleAuthProvider.credential(withIDToken: authen.idToken, accessToken: authen.accessToken)
        //success
        self.onLoginEvent.onNext(user)
    }
    
}
