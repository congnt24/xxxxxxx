//
//  OrderMain2ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class OrderMain2ViewController: UIViewController {
    
    @IBOutlet weak var navItem: UINavigationItem!
    var sectionName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.title = sectionName
    }
}
