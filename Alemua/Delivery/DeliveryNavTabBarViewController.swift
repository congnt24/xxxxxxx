//
//  DeliveryNavTabBarViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/24/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class DeliveryNavTabBarViewController: UITabBarController {
    
    public static var sharedInstance: DeliveryNavTabBarViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        DeliveryNavTabBarViewController.sharedInstance = self
        // Do any additional setup after loading the view.
    }
    
    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item")
    }
    
    
    
    func switchTab(index: Int){
        selectedIndex = index
    }

}
