//
//  DeliveryNavTabBarCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/24/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import AwesomeMVVM
import UIKit

class DeliveryNavTabBarCoordinator: Coordinator {
    public static var sharedInstance: DeliveryNavTabBarCoordinator!
    
    override func start(_ data: Any?) {
        let nav: DeliveryNavTabBarViewController = mainStoryboard.instantiateViewController(withClass: DeliveryNavTabBarViewController.self)
        DeliveryNavTabBarCoordinator.sharedInstance = self
        navigation?.pushViewController(nav, animated: true)
    }
}

