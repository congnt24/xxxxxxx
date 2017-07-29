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
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello World")
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
        navigationController?.popToRootViewController(animated: true)
    }
}

