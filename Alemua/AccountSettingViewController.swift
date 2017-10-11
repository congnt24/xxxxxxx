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
    let bag = DisposeBag()
    override func bindToViewModel() {
       
    }
    
    override func responseFromViewModel() {
        
    }
    
    @IBAction func onAccountInfo(_ sender: Any) {
        
        self.navigationController?.popViewController()
    }
    @IBAction func onHelp(_ sender: Any) {
        AccountCoordinator.sharedInstance.showAccountInfo(title: "Trợ giúp", url: "http://alemua.net/help.html")
    }
    
    
    @IBAction func onAppInfo(_ sender: Any) {
        AccountCoordinator.sharedInstance.showAccountInfo(title: "Thông tin ứng dụng", url: "http://alemua.net/info.html")
    }
    @IBAction func onLogout(_ sender: Any) {
        AlemuaApi.shared.aleApi.request(.logout())
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(_):
                    self.navigationController?.popToRootViewController(animated: true)
                    print("Logout success")
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
        Prefs.isUserLogged = false
        Prefs.userId = 0
        Prefs.apiToken = ""
        Prefs.userName = ""
        Prefs.address = ""
        Prefs.email = ""
        Prefs.desc = ""
        Prefs.phoneNumber = ""
    }
}

