//
//  NavTabBarCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import AwesomeMVVM
import UIKit

protocol NavTabBarCoordinatorDelegate {
    func showLoginScreen()
    func showChatScreen()
}

class NavTabBarCoordinator: Coordinator {
    override func start(_ data: Any?) {
        let nav: NavTabBarViewController = mainStoryboard.instantiateViewController(withClass: NavTabBarViewController.self)
        nav.coordinator = self
        NavTabBarViewController.AlemuaType = data as! HomeNaviType
        navigation?.popToRootViewController(animated: false)
        navigation?.pushViewController(nav, animated: true)
    }
}

extension NavTabBarCoordinator: NavTabBarCoordinatorDelegate {
    func showLoginScreen(){
        LoginCoordinator(navigation).start(nil)
    }
    func showChatScreen(){
        ChatCoordinator(navigation).start(nil)
    }
}
