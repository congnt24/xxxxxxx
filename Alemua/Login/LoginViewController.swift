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
import AccountKit
import Moya
import SwiftyJSON

class LoginViewController: BaseViewController, AKFViewControllerDelegate {
    var bag = DisposeBag()
    var accountKit: AKFAccountKit!
    override func bindToViewModel() {
        if accountKit == nil {
            accountKit = AKFAccountKit(responseType: .accessToken)
        }
    }

    override func responseFromViewModel() {
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        if (accountKit.currentAccessToken != nil) {
            // if the user is already logged in, go to the main screen
            print("User already logged in go to ViewController")
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    
    func viewController(_ viewController: UIViewController!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        print("Login succcess with AccessToken")
        accountKit.requestAccount { (account, err) in
            if let phone = account?.phoneNumber?.phoneNumber {
                AlemuaApi.shared.aleApi.request(AleApi.login(phone_number: phone, token_firebase: accessToken.tokenString, device_type: 2))
                    .toJSON()
                    .subscribe(onNext: { (res) in
                        switch res {
                        case .done(let result):
                            //TODO: Send to server
                            Prefs.apiToken = result["ApiToken"].stringValue
                            Prefs.userIdClient = result["id"].int!
                            print(Prefs.apiToken)
                            Prefs.isUserLogged = true
                            self.navigationController?.popViewController()
                            print("Cancel success")
                            break
                        case .error(let msg):
                            print("Error \(msg)")
                            break
                        default: break
                        }
                    }).addDisposableTo(self.bag)
            }
        }
        
    }
    func viewController(_ viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print("Login succcess with AuthorizationCode")
    }
    private func viewController(_ viewController: UIViewController!, didFailWithError error: NSError!) {
        print("We have an error \(error)")
    }
    func viewControllerDidCancel(_ viewController: UIViewController!) {
        print("The user cancel the login")
    }
    
    func prepareLoginViewController(_ loginViewController: AKFViewController) {
        
        loginViewController.delegate = self
//        loginViewController.advancedUIManager = nil
//        
//        //Costumize the theme
//        let theme:AKFTheme = AKFTheme.default()
//        theme.headerBackgroundColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
//        theme.headerTextColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//        theme.iconColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
//        theme.inputTextColor = UIColor(white: 0.4, alpha: 1.0)
//        theme.statusBarStyle = .default
//        theme.textColor = UIColor(white: 0.3, alpha: 1.0)
//        theme.titleColor = UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 1)
//        loginViewController.theme = theme
    }

    @IBAction func onIgnore(_ sender: Any) {
        navigationController?.popViewController()
        Prefs.isUserLogged = false
    }
    @IBAction func onPhone(_ sender: Any) {
        let inputState: String = UUID().uuidString
        let viewController:AKFViewController = accountKit.viewControllerForPhoneLogin(with: nil, state: inputState)  as! AKFViewController
        viewController.enableSendToFacebook = true
        self.prepareLoginViewController(viewController)
        self.present(viewController as! UIViewController, animated: true, completion: nil)
        //login with Email
//        let inputState: String = UUID().uuidString
//        let viewController: AKFViewController = accountKit.viewControllerForEmailLogin(withEmail: nil, state: inputState)  as! AKFViewController
//        self.prepareLoginViewController(viewController)
//        self.present(viewController as! UIViewController, animated: true, completion: { _ in })
        
    }
    
//
//    func facebookLogin() {
//        let loginManager = LoginManager()
//        loginManager.logIn([.publicProfile, .email], viewController: self) { (result) in
//            switch result {
//            case .cancelled:
//                print("Cancel button click")
//            case .success(let _, let _, let token):
//                print(token.authenticationToken)
//                Prefs.isUserLogged = true
//                self.navigationController?.popViewController()
////                TODO: AUTHEN BY FACEBOOK
////                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
//                
//                
//            default:
//                print("??")
//            }
//        }
//
//    }


}
