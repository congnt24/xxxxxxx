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
    func showDelivery()
}

class AppCoordinator : Coordinator {
    public static var sharedInstance: AppCoordinator!
    public var loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
    
    override func start(_ data: Any?) {
        HomeCoordinator(navigation).start(nil)
        AppCoordinator.sharedInstance = self
        //init account coor
        AccountCoordinator(navigation).start(nil)
        OrderCoordinator(navigation).start(nil)
        DeliveryCoordinator(navigation).start(nil)
    }
}
extension Coordinator {
    func getProfileStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Profile", bundle: nil)
    }
    
    func getDonHangStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "DonHang", bundle: nil)
    }
    func getLoginStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Login", bundle: nil)
    }
    func getBaoGiaStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "RaoVat", bundle: nil)
    }
}

extension AppCoordinator: AppCoordinatorDelegate {
    func back(){
        navigation?.popViewController(animated: true)
    }
    func showDelivery() {
        
    }
}
