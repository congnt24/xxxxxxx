//
//  AccountCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM

protocol AccountCoordinatorDelegate {
    func showAccountSetting()
    func showAccountInvite()
}

class AccountCoordinator: Coordinator {
    public static var sharedInstance: AccountCoordinator!
    override func start(_ data: Any?) {
        AccountCoordinator.sharedInstance = self
    }
    
    public func openEditAccount(){
        let account: EditAccountViewController = getProfileStoryboard().instantiateViewController(withClass: EditAccountViewController.self)
        account.coordinator = self
        navigation?.pushViewController(account, animated: true)
    }
}

extension AccountCoordinator: AccountCoordinatorDelegate {
    func showAccountSetting() {
        let account: AccountSettingViewController = getProfileStoryboard().instantiateViewController(withClass: AccountSettingViewController.self)
        account.coordinator = self
        navigation?.pushViewController(account, animated: true)
    }
    
    func showAccountInvite() {
        let account: AccountInviteViewController = getProfileStoryboard().instantiateViewController(withClass: AccountInviteViewController.self)
        account.coordinator = self
        navigation?.pushViewController(account, animated: true)
    }
    
    func showNotifyThanhToan(){
        let view: ThanhToanViewController = mainStoryboard.instantiateViewController(withClass: ThanhToanViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
}
