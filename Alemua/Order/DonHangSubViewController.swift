//
//  DonHangSubViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/23/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DonHangSubViewController: UIViewController, IndicatorInfoProvider {

    var itemInfo: IndicatorInfo!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        guard itemInfo != nil else {
            return IndicatorInfo(title: "Tab0")
        }
        return itemInfo
    }
}
