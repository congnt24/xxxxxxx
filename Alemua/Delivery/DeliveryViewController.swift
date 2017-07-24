//
//  DeliveryViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/24/17.
//  Copyright © 2017 cong. All rights reserved.
//
import UIKit
import XLPagerTabStrip

class DeliveryViewController: ButtonBarPagerTabStripViewController {
    
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
        let child1: SingleDeliveryViewController = UIStoryboard.mainStoryboard!.instantiateViewController(withClass: SingleDeliveryViewController.self)
        let child2: SingleDeliveryViewController = UIStoryboard.mainStoryboard!.instantiateViewController(withClass: SingleDeliveryViewController.self)
        let child3: SingleDeliveryViewController = UIStoryboard.mainStoryboard!.instantiateViewController(withClass: SingleDeliveryViewController.self)
        let child4: SingleDeliveryViewController = UIStoryboard.mainStoryboard!.instantiateViewController(withClass: SingleDeliveryViewController.self)
        
        child1.itemInfo = IndicatorInfo(title: "Báo giá")
        child2.itemInfo = IndicatorInfo(title: "Đang chuyển")
        child3.itemInfo = IndicatorInfo(title: "Thành công")
        child4.itemInfo = IndicatorInfo(title: "Đã hủy")
        child1.deliveryType = .DonMua
        child2.deliveryType = .BaoGia
        child3.deliveryType = .DangChuyen
        child4.deliveryType = .DaMua
        
        return [child1, child2, child3, child4]
    }
    
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {
        
    }
}
