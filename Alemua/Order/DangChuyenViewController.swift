//
//  DangChuyenViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM

class DangChuyenViewController: UIViewController {
    @IBOutlet weak var uiReview1: ReviewView!
    @IBOutlet weak var uiReview2: ReviewView!
    @IBOutlet weak var uiItemView: ItemView!
    @IBOutlet weak var tfMuaTu: AwesomeTextField!
    @IBOutlet weak var tfGiaoDen: AwesomeTextField!
    @IBOutlet weak var tfTruocNgay: AwesomeTextField!
    @IBOutlet weak var ifTongGia: AwesomeTextField!
    @IBOutlet weak var tfMoTa: AwesomeTextField!
    @IBOutlet weak var tfGhiChu: AwesomeTextField!
    @IBOutlet weak var uiDelivery: AwesomeToggleViewByHeight!
    @IBOutlet weak var uiOrder: UIStackView!

    @IBOutlet weak var uiRateDetail: RateDetail!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        if HomeViewController.homeType == .order {
            uiOrder.isHidden = false
            uiDelivery.heightConstraint?.constant = 0
        } else {
            uiOrder.isHidden = true
            uiDelivery.heightConstraint?.constant = 39
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onToggleMoreDetails(_ sender: Any) {
//        uiMoreDetails.toggleHeight()
    }

    @IBAction func onBaoXau(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showDangChuyenDialog1BaoXau()
    }

    @IBAction func onDaGiaoHangDelivery(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showDangChuyenDialog2DaGiao()
    }
    @IBAction func onDaGiaoHangOrder(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showDangChuyenDialog2DaGiao()
    }
    @IBAction func onHuyDon(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showDangChuyenDialog3HuyDon()
    }
    @IBOutlet weak var onToggleRateView: AwesomeToggleButton!
    @IBAction func onToggleRateDetail(_ sender: Any) {
        uiRateDetail.toggleHeight()
    }
}
