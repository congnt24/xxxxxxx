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
import GoogleSignIn
import FacebookLogin
import FBSDKLoginKit
import Toaster

class LoginViewController: BaseViewController, AKFViewControllerDelegate, GIDSignInUIDelegate {

    public static var shared: LoginViewController!

    public static var isIgnore = false;

    var bag = DisposeBag()
    var accountKit: AKFAccountKit!
    override func bindToViewModel() {
        LoginViewController.shared = self
        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().delegate = self
        if accountKit == nil {
            accountKit = AKFAccountKit(responseType: .accessToken)
        }
    }

    override func responseFromViewModel() {
    }


    func viewController(_ viewController: UIViewController!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        print("Login succcess with AccessToken")
        
        LoadingOverlay.shared.showOverlay(view: view)
        accountKit.requestAccount { (account, err) in
            if let phone = account?.phoneNumber?.phoneNumber {
                AlemuaApi.shared.aleApi.request(AleApi.login(phone_number: phone, password: ""))
                    .toJSON()
                    .subscribe(onNext: { (res) in
                        LoadingOverlay.shared.hideOverlayView()
                        switch res {
                        case .done(let result, _):
                            Prefs.isUserLogged = true
                            Prefs.userId = result["id"].int!
                            Prefs.apiToken = result["ApiToken"].string!
                            Prefs.phoneNumber = phone
                            Prefs.photo = result["photo"].string ?? ""
                            Prefs.userName = result["name"].string ?? "" //start socketio

                            SocketIOHelper.shared.connectToSocketIO()
                            self.navigationController?.popViewController(animated: false)
                            break
                        case .error(let msg):
                            print("Error \(msg)")
                            break
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
    @IBAction func onFacebook(_ sender: Any) {
        facebookLogin()
    }

    @IBAction func onGoogle(_ sender: Any) {
        googleLogin()
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

//MARK: Social Login
extension LoginViewController {
    func facebookLogin() {
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile, .email, .userFriends], viewController: self) { (result) in
            switch result {
            case .cancelled:
                print("Cancel button click")
            case .success( _, _, let token):
                
                LoadingOverlay.shared.showOverlay(view: self.view)
                let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name,email, picture.type(large)"], tokenString: token.authenticationToken, version: nil, httpMethod: "GET")
                graphRequest?.start(completionHandler: { (connection, result, error) in

                    if ((error) != nil) {
                        print("Error: \(String(describing: error))")
                    } else {
                        let data: [String: AnyObject] = result as! [String: AnyObject]
                        let email = data["email"]
                        let name = data["name"]
                        let photo = ((data["picture"] as! [String: Any])["data"] as! [String: Any])["url"]
                        let req = FacebookRequest()
                        req.email = (email as? String) ?? ""
                        req.name = (name as? String) ?? ""
                        req.facebookId = (data["id"] as? String) ?? ""
                        req.photo = (photo as? String) ?? ""
                        self.sendToServer(data: req)
                    }
                }) //                TODO: AUTHEN BY FACEBOOK
//                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
//                credential.
            default:
                print("??")
            }
        }
    }
    func googleLogin() {
        GIDSignIn.sharedInstance().signIn()
//        GIDSignIn.sharedInstance().
    }


    func sendToServer(data: FacebookRequest) {
        LoadingOverlay.shared.showOverlay(view: view)
        data.deviceType = 2
        data.phoneNumber = ""
        data.tokenFirebase = Prefs.firebaseToken
        AlemuaApi.shared.aleApi.request(AleApi.loginAndRegisterFacebook(data: data))
            .toJSON()
            .subscribe(onNext: { (res) in
                LoadingOverlay.shared.hideOverlayView()
                switch res {
                case .done(let result, let msg):
                    Prefs.isUserLogged = true
                    Prefs.userId = result["id"].int!
                    Prefs.apiToken = result["ApiToken"].string!
//                    Prefs.phoneNumber = phone
                    Prefs.photo = result["photo"].string ?? ""
                    Prefs.userName = result["name"].string ?? "" //start socketio
                    self.navigationController?.popViewController()

                    Toast.init(text: msg).show()
                    break
                case .error(let msg):

                    Toast.init(text: msg).show()
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }


    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
//        myActivityIndicator.stopAnimating()
    }

    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }

    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
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
