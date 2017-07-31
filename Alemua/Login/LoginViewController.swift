//
//  LoginViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa
import FacebookLogin
import FacebookCore
import Firebase

class LoginViewController: BaseViewController {
    var bag = DisposeBag()

    override func bindToViewModel() {

    }

    override func responseFromViewModel() {

    }

    override func viewWillAppear(_ animated: Bool) {

        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    override func viewWillDisappear(_ animated: Bool) {

        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    @IBAction func onIgnore(_ sender: Any) {
        navigationController?.popViewController()
        Prefs.isUserLogged = false
    }
    @IBAction func onPhone(_ sender: Any) {
        Prefs.isUserLogged = true
        navigationController?.popViewController()
    }
    @IBAction func onFacebook(_ sender: Any) {
//        Prefs.isUserLogged = true
//        navigationController?.popViewController()
        facebookLogin()
    }
    @IBAction func onGoogle(_ sender: Any) {
        Prefs.isUserLogged = true
        navigationController?.popViewController()
    }


    func facebookLogin() {
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .cancelled:
                print("Cancel button click")
            case .success(let _, let _, let token):
                print(token.authenticationToken)
                Prefs.isUserLogged = true
                self.navigationController?.popViewController()
//                TODO: AUTHEN BY FACEBOOK
//                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                
                
            default:
                print("??")
            }
        }

    }


}
