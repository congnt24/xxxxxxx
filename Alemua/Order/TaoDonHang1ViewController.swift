//
//  TaoDonHang1ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/26/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import AwesomeMVVM

class TaoDonHang1ViewController: UIViewController, IndicatorInfoProvider  {

    @IBOutlet weak var tfTenSP: AwesomeTextField!
    @IBOutlet weak var tfMota: AwesomeTextField!
    @IBOutlet weak var tfWebsite: AwesomeTextField!
    @IBOutlet weak var tfGia: AwesomeTextField!
    @IBOutlet weak var tfCode: AwesomeTextField!
    @IBOutlet weak var stSoLuong: StepperView!
    @IBOutlet weak var grSelect: AwesomeRadioGroupCell!
    var taodonhangRequest: TaoDonHangRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taodonhangRequest = (parent as! TaoDonHangViewController).taodonhangRequest
        // Do any additional setup after loading the view.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Thông tin")
    }

    @IBAction func onNext(_ sender: Any) {
        TaoDonHangViewController.sharedInstance.moveToViewController(at: 1)
    }
    
    func setData(){
        taodonhangRequest.productName = tfTenSP.text
        taodonhangRequest.productDescription = tfMota.text
        taodonhangRequest.websiteUrl = tfWebsite.text
        taodonhangRequest.websitePrice = Int(tfGia.text!)
        taodonhangRequest.promotionCode = tfCode.text
        taodonhangRequest.quantity = stSoLuong.number
    }
}
