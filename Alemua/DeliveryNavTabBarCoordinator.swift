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
        if let data = data as? Int, data > -1 {
            switch data {
            case 2:
                DeliveryOrderViewController.defaultTab = 1
                nav.defaultTab = 1
                break
            case 3:
                DeliveryOrderViewController.defaultTab = 3
                nav.defaultTab = 1
                break
            case 4:
                DeliveryOrderViewController.defaultTab = 2
                nav.defaultTab = 1
                break
            default:  //-> 9.1
                nav.defaultTab = 0
                nav.showThanhToan = true
            }
        }
        DeliveryNavTabBarCoordinator.sharedInstance = self
        navigation?.pushViewController(nav, animated: true)
    }
}

