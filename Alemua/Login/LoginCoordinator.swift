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
    override func start(_ data: Any?) {
        let login: LoginViewController = getLoginStoryboard().instantiateViewController(withClass: LoginViewController.self)
        //        chat.chatCoor = self
        navigation?.pushViewController(login)
    }
}
