//
//  DonHangViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DonHangViewController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = UIColor(hexString: "#3A99D8")!
        settings.style.buttonBarItemBackgroundColor = UIColor.clear
        settings.style.selectedBarHeight = 2
        settings.style.selectedBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        //        settings.style.buttonBarMinimumLineSpacing = 10
        //        settings.style.buttonBarItemLeftRightMargin = 0
        //change font size
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 15)
        // Do any additional setup after loading the view.
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let donhang: DonHangSubViewController = UIStoryboard(name: "DonHang", bundle: nil).instantiateViewController(withClass: DonHangSubViewController.self)
        let baogia: BaoGiaSubViewController = UIStoryboard(name: "DonHang", bundle: nil).instantiateViewController(withClass: BaoGiaSubViewController.self)
        
        donhang.itemInfo = IndicatorInfo(title: "Đơn hàng")
        baogia.itemInfo = IndicatorInfo(title: "Báo giá")
        
        return [donhang, baogia]
    }
    
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {
        
    }
}
