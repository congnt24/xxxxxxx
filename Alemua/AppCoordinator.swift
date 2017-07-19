//
//  AppCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import AwesomeMVVM
import UIKit


protocol AppCoordinatorDelegate {
    func showOrder()
    func showDelivery()
}

class AppCoordinator : Coordinator {
    public var loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
    
    override func start(_ data: Any?) {
        HomeCoordinator(navigation).start(nil)
    }
}
extension Coordinator {
    func getProfileStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Profile", bundle: nil)
    }
}

extension AppCoordinator: AppCoordinatorDelegate {
    func showOrder() {
        
    }
    func showDelivery() {
        
    }
}
