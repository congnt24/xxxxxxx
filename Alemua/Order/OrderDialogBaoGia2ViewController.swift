//
//  OrderDialogBaoGia2ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class OrderDialogBaoGia2ViewController: UIViewController {

    @IBOutlet weak var lbSoDonHang: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onNext(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showBaoGiaDetailDialog3()
    }
}
