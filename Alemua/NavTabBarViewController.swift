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

class NavTabBarViewController: UITabBarController {
    var coordinator: OrderNavTabBarCoordinator!
    public static var AlemuaType = HomeNaviType.Order
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
