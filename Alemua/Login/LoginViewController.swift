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
        Prefs.isUserLogged = true
        navigationController?.popViewController()
    }
    @IBAction func onGoogle(_ sender: Any) {
        Prefs.isUserLogged = true
        navigationController?.popViewController()
    }
}
