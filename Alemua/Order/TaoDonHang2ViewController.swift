//
//  TaoDonHang2ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/26/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import AwesomeMVVM

class TaoDonHang2ViewController: UIViewController, IndicatorInfoProvider {
    @IBOutlet weak var tfMuaTu: AwesomeTextField!
    @IBOutlet weak var tfGiaoDen: AwesomeTextField!
    @IBOutlet weak var tfNgay: AwesomeTextField!
    @IBOutlet weak var tfNote: AwesomeTextField!
    var taodonhangRequest: TaoDonHangRequest!

    @IBOutlet weak var uiRateDetail: RateDetail!
    override func viewDidLoad() {
        super.viewDidLoad()
        taodonhangRequest = TaoDonHang1ViewController.sharedInstance.taodonhangRequest

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Vận chuyển")
    }

    @IBAction func onNext(_ sender: Any) {
        setData()
        if taodonhangRequest.validateStep2() {
            TaoDonHangViewController.sharedInstance.moveToViewController(at: 2)
            print("Tao don hang 2")
            print(taodonhangRequest)
        } else {
            print("ERROR")
        }
    }
    
    func setData(){
        taodonhangRequest.buyFrom = tfMuaTu.text
        taodonhangRequest.deliveryTo = tfGiaoDen.text
        taodonhangRequest.deliveryDate = tfNgay.text
    }
}
