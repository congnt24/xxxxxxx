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
//    func showDeliveryScreen()
//    func showOrderScreen()
//    func showDeliveryScreen()
}

class HomeCoordinator: Coordinator {
    public static var sharedInstance: HomeCoordinator!
    override func start(_ data: Any?) {
        HomeCoordinator.sharedInstance = self
        let home: HomeViewController = mainStoryboard.instantiateViewController(withClass: HomeViewController.self)
        home.coordinator = self
        navigation?.popToRootViewController(animated: false)
        navigation?.setViewControllers([home], animated: false)
    }
}

extension HomeCoordinator: HomeCoordinatorDelegate {
    func showDeliveryScreen(_ navigate: Int = -1) {
        DeliveryNavTabBarCoordinator(navigation).start(nil)
    }
    func showOrderScreen(_ navigate: Int = -1) {
        OrderNavTabBarCoordinator(navigation).start(navigate)
    }
    func showRaoVatScreen(){
        RaoVatCoordinator(navigation).start(nil)
    }
    
    
    func showOrderScreenNoti1() {
        OrderNavTabBarCoordinator(navigation).start(nil)
    }
}

extension HomeCoordinator {
    func showLoginScreen() {
        LoginCoordinator(navigation).start(nil)
    }
    
    func showChatScreen(friend: ConversationUserData) {
        ChatCoordinator(navigation).start(friend)
    }
    func showChatScreen(data: String) {
        let chat: ChatWrapperViewController = mainStoryboard.instantiateViewController(withClass: ChatWrapperViewController.self)
        chat.data = data
        //        chat.chatCoor = self
        navigation?.pushViewController(chat)
    }
}
