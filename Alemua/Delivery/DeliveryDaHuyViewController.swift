//
//  DeliveryDaHuyViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class DeliveryDaHuyViewController: UIViewController {

    @IBOutlet weak var rateDetail: RateDetail!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func onShowModeRateDetail(_ sender: Any) {
        rateDetail.toggleHeight()
    }
}
