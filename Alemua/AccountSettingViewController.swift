//
//  AccountSettingViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//
import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class AccountSettingViewController: BaseViewController {
    var coordinator: AccountCoordinator!
    override func bindToViewModel() {
       
    }
    
    override func responseFromViewModel() {
        
    }
    
    @IBAction func onAccountInfo(_ sender: Any) {
    }
    @IBAction func onHelp(_ sender: Any) {
    }
    
    
    @IBAction func onAppInfo(_ sender: Any) {
    }
    @IBAction func onLogout(_ sender: Any) {
        Prefs.isUserLogged = false
        Prefs.userId = 0
        Prefs.apiToken = ""
        navigationController?.popToRootViewController(animated: true)
    }
}

