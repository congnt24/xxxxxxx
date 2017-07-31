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
    @IBOutlet weak var itemView: ItemView!
    @IBOutlet weak var tfMuaTu: AwesomeTextField!
    @IBOutlet weak var tfGiaoDen: AwesomeTextField!
    @IBOutlet weak var tfNgay: AwesomeTextField!
    @IBOutlet weak var tfGia: AwesomeTextField!
    var taodonhangRequest: TaoDonHangRequest!

    @IBOutlet weak var uiRateDetail: RateDetail!
    override func viewDidLoad() {
        super.viewDidLoad()
//        taodonhangRequest = (parent as! TaoDonHangViewController).taodonhangRequest

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Vận chuyển")
    }
    @IBAction func onShowMoreDetail(_ sender: Any) {
        uiRateDetail.toggleHeight()
    }


    @IBAction func onNext(_ sender: Any) {
        TaoDonHangViewController.sharedInstance.moveToViewController(at: 2)
    }
    
    func setData(){
        taodonhangRequest.buyFrom = tfMuaTu.text
        taodonhangRequest.deliveryTo = tfGiaoDen.text
        taodonhangRequest.deliveryDate = tfNgay.text
    }
}
