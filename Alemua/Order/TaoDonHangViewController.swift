//
//  TaoDonHangViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TaoDonHangRequest {
    public var productOption: Int?
    public var note: String?
    public var buyFrom: String?
    public var websitePrice: Int?
    public var deliveryDate: String?
    public var websiteUrl: String?
    public var quantity: Int?
    public var productName: String?
    public var promotionCode: String?
    public var productDescription: String?
    public var deliveryTo: String?
    public var transactionOption: Int?
    public var userID: Int?
    public var photo: String?
    public var apiToken: String?
}

class TaoDonHangViewController: ButtonBarPagerTabStripViewController {
    //create post object and use it in 3 subviews controller
    //call using superviewcontroller
    var taodonhangRequest = TaoDonHangRequest()
    public static var sharedInstance: TaoDonHangViewController!
    
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
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 15)
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        TaoDonHangViewController.sharedInstance = self
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1: TaoDonHang1ViewController = UIStoryboard.mainStoryboard!.instantiateViewController(withClass: TaoDonHang1ViewController.self)
        let child2: TaoDonHang2ViewController = UIStoryboard.mainStoryboard!.instantiateViewController(withClass: TaoDonHang2ViewController.self)
        let child3: TaoDonHang3ViewController = UIStoryboard.mainStoryboard!.instantiateViewController(withClass: TaoDonHang3ViewController.self)
        return [child1, child2, child3]
    }

    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {

    }
}
