//
//  DeliveryFilterViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/29/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class DeliveryFilterViewController: UIViewController {
    
    @IBOutlet weak var view1: AwesomeUIView!
    @IBOutlet weak var view2: AwesomeUIView!
    @IBOutlet weak var view3: AwesomeUIView!
    
    var listChecked: [UIView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listChecked = [view1.subviews[0].subviews[2], view2.subviews[0].subviews[2], view3.subviews[0].subviews[2]]
        view1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onView1)))
        view2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onView2)))
        view3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onView3)))
        onView1()
    }
    
    func onView1() {
        for check in listChecked {
            check.isHidden = true
        }
        listChecked[0].isHidden = false
    }
    func onView2() {
        for check in listChecked {
            check.isHidden = true
        }
        listChecked[1].isHidden = false
    }
    func onView3() {
        for check in listChecked {
            check.isHidden = true
        }
        listChecked[2].isHidden = false
    }
    
}
