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

enum HomeNaviType {
    case Delivery
    case Order
}

protocol HomeCoordinatorDelegate {
    func showDeliveryScreen()
    func showOrderScreen()
//    func showDeliveryScreen()
}

class HomeCoordinator: Coordinator {
    override func start(_ data: Any?) {
        let home: HomeViewController = mainStoryboard.instantiateViewController(withClass: HomeViewController.self)
        home.coordinator = self
        navigation?.popToRootViewController(animated: false)
        navigation?.setViewControllers([home], animated: false)
        //        navigation?.pushViewController(home, animated: true)
    }
}

extension HomeCoordinator: HomeCoordinatorDelegate {
    func showDeliveryScreen(){
        NavTabBarCoordinator(navigation).start(HomeNaviType.Delivery)
    }
    func showOrderScreen(){
        NavTabBarCoordinator(navigation).start(HomeNaviType.Order)
    }
}
