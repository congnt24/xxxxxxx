//
//  OrderViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//


import UIKit
import XLPagerTabStrip

class OrderOrderViewController: ButtonBarPagerTabStripViewController {

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
        let child1: SingleOrderViewController = UIStoryboard.mainStoryboard!.instantiateViewController(withClass: SingleOrderViewController.self)
        let child2: SingleOrderViewController = UIStoryboard.mainStoryboard!.instantiateViewController(withClass: SingleOrderViewController.self)
        let child3: SingleOrderViewController = UIStoryboard.mainStoryboard!.instantiateViewController(withClass: SingleOrderViewController.self)
        let child4: SingleOrderViewController = UIStoryboard.mainStoryboard!.instantiateViewController(withClass: SingleOrderViewController.self)
        
        child1.itemInfo = IndicatorInfo(title: "Đơn mua")
        child2.itemInfo = IndicatorInfo(title: "Báo giá")
        child3.itemInfo = IndicatorInfo(title: "Đang chuyển")
        child4.itemInfo = IndicatorInfo(title: "Đã mua")
        child1.orderType = .DonMua
        child2.orderType = .BaoGia
        child3.orderType = .DangChuyen
        child4.orderType = .DaMua
        
        return [child1, child2, child3, child4]
    }

    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {

    }
}
