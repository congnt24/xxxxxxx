//
//  FirebaseAuth.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/30/17.
//  Copyright © 2017 cong. All rights reserved.
//
/*
import Foundation
import Firebase
import GoogleSignIn
import RxSwift

/**
 Handle login by google
 */
class FirebaseAuthHelper: NSObject, GIDSignInDelegate {
    var onLoginEvent = PublishSubject<User?>()
    private static var _instance: FirebaseAuthHelper? = nil
    static func instance() -> FirebaseAuthHelper {
        return _instance!
    }
    
    static func configure() {
        _instance = FirebaseAuthHelper()
    }
    
    override init() {
        super.init()
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
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
        //authen firebase
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                self.onLoginEvent.onError(error)
                return
            }
            //success
            self.onLoginEvent.onNext(user)
        }
        
    }
    
}
*/
