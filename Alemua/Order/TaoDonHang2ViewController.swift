//
//  TaoDonHang2ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/26/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TaoDonHang2ViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var uiRateDetail: RateDetail!
    override func viewDidLoad() {
        super.viewDidLoad()

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


}
