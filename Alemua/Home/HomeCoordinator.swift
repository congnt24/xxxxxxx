//
//  HomeCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import AwesomeMVVM
import UIKit

protocol HomeCoordinatorDelegate {
    func showLoginScreen()
    func showChatScreen()
//    func showDeliveryScreen()
}

class HomeCoordinator: Coordinator {
    override func start(_ data: Any?) {
        let home: HomeViewController = mainStoryboard.instantiateViewController(withClass: HomeViewController.self)
        //create and assign view model
        //create and assign delegate = self
        //push navigation
//        let viewModel = HomeViewModel(delegate: self)
//        viewModel.delegate = self
//        home.viewModel = viewModel
        home.coordinator = self
        navigation?.popToRootViewController(animated: false)
        navigation?.setViewControllers([home], animated: false)
        //        navigation?.pushViewController(home, animated: true)
    }
}

extension HomeCoordinator: HomeCoordinatorDelegate {
    func showLoginScreen(){
        LoginCoordinator(navigation).start(nil)
    }
    func showChatScreen(){
        ChatCoordinator(navigation).start(nil)
    }
}
