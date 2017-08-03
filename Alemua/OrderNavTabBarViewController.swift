//
//  NavTabBarViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class OrderNavTabBarViewController: UITabBarController {
    public static var sharedInstance: OrderNavTabBarViewController!
    var coordinator: OrderNavTabBarCoordinator!
    override func viewDidLoad() {
        super.viewDidLoad()
        OrderNavTabBarViewController.sharedInstance = self
        
        // Do any additional setup after loading the view.
    }
    
    func switchTab(index: Int){
        selectedIndex = index
    }
}
