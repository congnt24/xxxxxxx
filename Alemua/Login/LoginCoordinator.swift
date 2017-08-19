//
//  LoginCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import AwesomeMVVM
import UIKit

class LoginCoordinator: Coordinator {
    public static var sharedInstance: LoginCoordinator!
    override func start(_ data: Any?) {
        LoginCoordinator.sharedInstance = self
        let login: LoginViewController = getLoginStoryboard().instantiateViewController(withClass: LoginViewController.self)
        navigation?.pushViewController(login)
    }
    
    func showLoginByPassword(){
        let login: LoginByPasswordViewController = getLoginStoryboard().instantiateViewController(withClass: LoginByPasswordViewController.self)
        navigation?.pushViewController(login)
    }
}
