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

class OrderNavTabBarCoordinator: Coordinator {
    public static var sharedInstance: OrderNavTabBarCoordinator!
    
    override func start(_ data: Any?) {
        let nav: OrderNavTabBarViewController = mainStoryboard.instantiateViewController(withClass: OrderNavTabBarViewController.self)
        OrderNavTabBarCoordinator.sharedInstance = self
        nav.coordinator = self
        navigation?.pushViewController(nav, animated: true)
    }
}



