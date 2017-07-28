//
//  DeliveryBaoGiaFinalViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/28/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class DeliveryBaoGiaFinalViewController: UIViewController {

    @IBOutlet weak var rateDetail: RateDetail!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onShowMoreRateDetail(_ sender: Any) {
        rateDetail.toggleHeight()
    }
    @IBAction func onFinishBaoGia(_ sender: Any) {
    }
}
