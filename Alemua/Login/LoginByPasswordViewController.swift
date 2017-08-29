//
//  LoginByPasswordViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa
import AccountKit
import Moya
import SwiftyJSON

class LoginByPasswordViewController: BaseViewController, AKFViewControllerDelegate {

    @IBOutlet weak var lbError: UILabel!
    @IBOutlet weak var tfUser: AwesomeTextField!
    @IBOutlet weak var tfPass: AwesomeTextField!
    var bag = DisposeBag()
    var accountKit: AKFAccountKit!
    override func bindToViewModel() {
        if accountKit == nil {
            accountKit = AKFAccountKit(responseType: .accessToken)
        }
    }

    override func responseFromViewModel() {
    }

    func viewController(_ viewController: UIViewController!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        print("Login succcess with AccessToken")
        accountKit.requestAccount { (account, err) in
            if let phone = account?.phoneNumber?.phoneNumber {
                AlemuaApi.shared.aleApi.request(AleApi.activeAccount(phone_number: phone, password: self.tfPass.text!))
                    .toJSON()
                    .subscribe(onNext: { (res) in
                        switch res {
                        case .done(let result):
                            self.login(phone: phone, pass: self.tfPass.text!)
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
        
        loginViewController.defaultCountryCode = "VN"
    }

    func login(phone: String, pass: String) {
        AlemuaApi.shared.aleApi.request(AleApi.login(phone_number: phone, password: pass))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    //TODO: Send to server
                    Prefs.apiToken = result["ApiToken"].string!
                    Prefs.userIdClient = result["id"].int!
                    print(Prefs.apiToken)
                    Prefs.isUserLogged = true
                    self.navigationController?.popViewController(animated: false)
                    print("Success success")
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    if msg == "" {
                        //active account by accoutkit//Show login by account kit
                        let inputState: String = UUID().uuidString
                        let viewController: AKFViewController = self.accountKit.viewControllerForPhoneLogin(with: nil, state: inputState) as! AKFViewController
                        viewController.enableSendToFacebook = true
                        self.prepareLoginViewController(viewController)
                        self.present(viewController as! UIViewController, animated: true, completion: nil)
                    }else{
                        self.lbError.text = msg
                    }
                    break
                }
            }).addDisposableTo(self.bag)
    }

    @IBAction func onLogin(_ sender: Any) {
        if let phone = tfUser.text, let pass = tfPass.text, phone != "", pass != "" {
            login(phone: phone, pass: pass)
        } else {

        }






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
