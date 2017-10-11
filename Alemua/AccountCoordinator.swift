//
//  AccountCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM


class AccountCoordinator: Coordinator {
    public static var sharedInstance: AccountCoordinator!
    override func start(_ data: Any?) {
        AccountCoordinator.sharedInstance = self
    }
    
    public func openEditAccount(data: ProfileData?){
        let account: EditAccountViewController = getProfileStoryboard().instantiateViewController(withClass: EditAccountViewController.self)
        account.coordinator = self
        account.data = data
        navigation?.pushViewController(account, animated: true)
    }
    public func openEditAccount(user_id: Int){
        let account: EditAccountViewController = getProfileStoryboard().instantiateViewController(withClass: EditAccountViewController.self)
        account.coordinator = self
        account.user_id = user_id
        navigation?.pushViewController(account, animated: true)
    }
}

extension AccountCoordinator {
    func showAccountSetting() {
        let account: AccountSettingViewController = getProfileStoryboard().instantiateViewController(withClass: AccountSettingViewController.self)
        account.coordinator = self
        navigation?.pushViewController(account, animated: true)
    }
    
    func showAccountInvite(code: String?) {
        let account: AccountInviteViewController = getProfileStoryboard().instantiateViewController(withClass: AccountInviteViewController.self)
        account.coordinator = self
        account.inviteCode = code!
        navigation?.pushViewController(account, animated: true)
    }
    
    func showNotifyThanhToan(){
        let view: ThanhToanViewController = mainStoryboard.instantiateViewController(withClass: ThanhToanViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    
    func showAccountInfo(title: String!, url: String!){
        let view: AccountInfoViewController = getProfileStoryboard().instantiateViewController(withClass: AccountInfoViewController.self)
        view.titleStr = title
        view.url = url
        navigation?.pushViewController(view, animated: true)
    }
}
