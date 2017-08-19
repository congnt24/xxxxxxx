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

class LoginViewController: BaseViewController {
    
    public static var isIgnore = false;
    
    var bag = DisposeBag()
    override func bindToViewModel() {
    }

    override func responseFromViewModel() {
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
        LoginCoordinator.sharedInstance.showLoginByPassword()
    }
}
