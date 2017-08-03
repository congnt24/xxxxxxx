//
//  AccountViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//


import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class AccountViewController: BaseViewController {
    @IBOutlet weak var uiMoreDetails: AwesomeToggleViewByHeight!
    @IBOutlet weak var uiSwitchNotify: UISwitch!
    @IBOutlet weak var uiNotify: UIStackView!
    @IBOutlet weak var uiSetting: UIStackView!
    @IBOutlet weak var uiInviteFriend: UIStackView!
    
    @IBOutlet weak var userView: UserView!
    override func bindToViewModel() {
        let tapSetting = UITapGestureRecognizer(target: self, action: #selector(self.showAccountSetting(_:)))
        let tapInvite = UITapGestureRecognizer(target: self, action: #selector(self.showAccountInvite(_:)))
        uiSetting.addGestureRecognizer(tapSetting)
        uiInviteFriend.addGestureRecognizer(tapInvite)
        uiNotify.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.toggleNotify(_:))))
        
        userView.toggleView = {
            self.uiMoreDetails.toggleHeight()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //TODO: Check if user is logged
        if !Prefs.isUserLogged {
            HomeCoordinator.sharedInstance.showLoginScreen()
            return
        }
        
    }
    
    

    func toggleNotify(_ sender: UITapGestureRecognizer) {
        uiSwitchNotify.isOn = !uiSwitchNotify.isOn
    }

    func showAccountSetting(_ sender: UITapGestureRecognizer) {
        AccountCoordinator.sharedInstance.showAccountSetting()
    }

    func showAccountInvite(_ sender: UITapGestureRecognizer) {
        AccountCoordinator.sharedInstance.showAccountInvite()
    }
    override func responseFromViewModel() {

    }

    @IBAction func onEditAccount(_ sender: Any) {
        AccountCoordinator.sharedInstance.openEditAccount()
    }
    @IBAction func onNotifyChange(_ sender: UISwitch) {
        print("Switch \(sender.isOn)")
    }
    
    @IBAction func onBack(_ sender: Any) {
        if HomeViewController.homeType == .order {
            OrderNavTabBarViewController.sharedInstance.switchTab(index: 0)
        }else{
            DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 0)
        }
    }
}

