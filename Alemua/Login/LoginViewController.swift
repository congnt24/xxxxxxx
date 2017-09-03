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
    
    public static var isIgnore = false;
    
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
                AlemuaApi.shared.aleApi.request(AleApi.login(phone_number: phone, password: ""))
                    .toJSON()
                    .subscribe(onNext: { (res) in
                        switch res {
                        case .done(let result, _):
                            Prefs.isUserLogged = true
                            Prefs.userId = result["id"].int!
                            Prefs.apiToken = result["ApiToken"].string!
                            Prefs.phoneNumber = phone
                            Prefs.photo = result["photo"].string ?? ""
                            Prefs.userName = result["name"].string ?? ""                            //start socketio
                            
                            SocketIOHelper.shared.connectToSocketIO()
                            self.navigationController?.popViewController(animated: false)
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

    
    override func viewWillAppear(_ animated: Bool) {
        LoginViewController.isIgnore = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        if Prefs.isUserLogged {
            self.navigationController?.popViewController()
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    @IBAction func onIgnore(_ sender: Any) {
        LoginViewController.isIgnore = true
        navigationController?.popViewController()
    }
    @IBAction func onPhone(_ sender: Any) {
//        LoginCoordinator.sharedInstance.showLoginByPassword()
        //active account by accoutkit//Show login by account kit
        let inputState: String = UUID().uuidString
        let viewController: AKFViewController = self.accountKit.viewControllerForPhoneLogin(with: nil, state: inputState) as! AKFViewController
        viewController.enableSendToFacebook = true
        self.prepareLoginViewController(viewController)
        self.present(viewController as! UIViewController, animated: true, completion: nil)
    }
}







//class LoginViewController: BaseViewController {
//    
//    public static var isIgnore = false;
//    
//    var bag = DisposeBag()
//    override func bindToViewModel() {
//    }
//    
//    override func responseFromViewModel() {
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        LoginViewController.isIgnore = false
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//        if Prefs.isUserLogged {
//            self.navigationController?.popViewController()
//        }
//        
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
//    }
//    
//    @IBAction func onIgnore(_ sender: Any) {
//        LoginViewController.isIgnore = true
//        navigationController?.popViewController()
//    }
//    @IBAction func onPhone(_ sender: Any) {
//        LoginCoordinator.sharedInstance.showLoginByPassword()
//    }
//}



//import UIKit
//import AwesomeMVVM
//import RxSwift
//import RxCocoa
//import AccountKit
//import Moya
//import SwiftyJSON
//
//class LoginViewController: BaseViewController, AKFViewControllerDelegate {
//    public static var isIgnore = false;
//    @IBOutlet weak var loginFacebook: UIView!
//    
//    var bag = DisposeBag()
//    var accountKit: AKFAccountKit!
//    
//    
//    override func bindToViewModel() {
//        loginFacebook.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLoginFacebook)))
//        if accountKit == nil {
//            accountKit = AKFAccountKit(responseType: .accessToken)
//        }
//    }
//    
//    func viewController(_ viewController: UIViewController!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
//        print("Login succcess with AccessToken")
//        accountKit.requestAccount { (account, err) in
//            if let phone = account?.phoneNumber?.phoneNumber {
//                let loginReq = LoginRequest()
//                loginReq.phone_number = phone
//                loginReq.email = account?.emailAddress
//                loginReq.fbId = account?.accountID
//                loginReq.token_firebase = ""
//                CheckinService.shared.api.request(CheckinApi.login(data: loginReq))
//                    .toJSON()
//                    .subscribe(onNext: { (res) in
//                        switch res {
//                        case .done(let result):
//                            Prefs.isUserLogged = true
//                            Prefs.userId = result["id"].int!
//                            Prefs.apiToken = result["ApiToken"].string!
//                            Prefs.phoneNumber = phone
//                            HomeCoordinator.sharedInstance.showHome()
//                            break
//                        case .error(let msg):
//                            print("Error \(msg)")
//                            break
//                        }
//                    }).addDisposableTo(self.bag)
//            }
//        }
//        
//    }
//    func viewController(_ viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
//        print("Login succcess with AuthorizationCode")
//    }
//    private func viewController(_ viewController: UIViewController!, didFailWithError error: NSError!) {
//        print("We have an error \(error)")
//    }
//    func viewControllerDidCancel(_ viewController: UIViewController!) {
//        print("The user cancel the login")
//    }
//    
//    func prepareLoginViewController(_ loginViewController: AKFViewController) {
//        loginViewController.delegate = self
//        //                loginViewController.setAdvancedUIManager(nil)
//        //Costumize the theme
//        let theme:AKFTheme = AKFTheme.default()
//        theme.headerBackgroundColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
//        theme.headerTextColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//        theme.iconColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
//        theme.inputTextColor = UIColor(white: 0.4, alpha: 1.0)
//        theme.statusBarStyle = .default
//        theme.textColor = UIColor(white: 0.3, alpha: 1.0)
//        theme.titleColor = UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 1)
//        loginViewController.setTheme(theme)
//        loginViewController.defaultCountryCode = "VN"
//    }
//    
//    
//    override func viewWillAppear(_ animated: Bool) {
//        if Prefs.isUserLogged {
//            HomeCoordinator.sharedInstance.showHome()
//        }
//        
//    }
//    
//    func onLoginFacebook() {
//        //active account by accoutkit//Show login by account kit
//        let inputState: String = UUID().uuidString
//        let viewController: AKFViewController = self.accountKit.viewControllerForPhoneLogin(with: nil, state: inputState) as! AKFViewController
//        viewController.enableSendToFacebook = true
//        self.prepareLoginViewController(viewController)
//        self.present(viewController as! UIViewController, animated: true, completion: nil)
//    }
//    
//    @IBAction func onSkip(_ sender: Any) {
//        Prefs.isUserLogged = false
//        HomeCoordinator.sharedInstance.showHome()
//    }
//}
