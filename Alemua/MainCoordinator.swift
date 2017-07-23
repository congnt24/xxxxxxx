//
//  MainCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//


import Foundation
import AwesomeMVVM
import UIKit

protocol MainCoordinatorDelegate {
    func showLoginScreen()
    func showChatScreen()
}

class MainCoordinator: Coordinator {
    override func start(_ data: Any?) {
        let main: MainViewController = mainStoryboard.instantiateViewController(withClass: MainViewController.self)
        main.coordinator = self
        navigation?.popToRootViewController(animated: false)
        navigation?.pushViewController(main, animated: true)
    }
}

extension MainCoordinator: MainCoordinatorDelegate {
    func showLoginScreen(){
        LoginCoordinator(navigation).start(nil)
    }
    func showChatScreen(){
        ChatCoordinator(navigation).start(nil)
    }
}
