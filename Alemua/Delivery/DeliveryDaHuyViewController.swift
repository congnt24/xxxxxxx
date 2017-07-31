//
//  DeliveryDaHuyViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM

class DeliveryDaHuyViewController: UIViewController {
    @IBOutlet weak var itemView: ItemView!

    @IBOutlet weak var tfMuatu: AwesomeTextField!
    @IBOutlet weak var tfGiaoden: AwesomeTextField!
    @IBOutlet weak var tfNgay: AwesomeTextField!
    @IBOutlet weak var tfGia: AwesomeTextField!
    @IBOutlet weak var tfLydo: AwesomeTextField!
    @IBOutlet weak var tfGhichu: AwesomeTextField!
    @IBOutlet weak var rateDetail: RateDetail!
    @IBOutlet weak var review: ReviewView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func onShowModeRateDetail(_ sender: Any) {
        rateDetail.toggleHeight()
    }
}
