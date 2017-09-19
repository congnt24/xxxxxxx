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
    public static var shared: OrderOrderViewController!
    @IBAction func onBack(_ sender: Any) {
        if HomeViewController.homeType == .order {
            OrderNavTabBarViewController.sharedInstance.switchTab(index: 0)
        }else{
            DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 0)
        }
    }
    
    var listVc = [SingleOrderViewController]()
    public static var selectViewController = -1
    
    var indexShouldReload = [Int]()
    var cacheFilter = -1
    
    
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = UIColor(hexString: "#E94F2E")!
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
        OrderOrderViewController.shared = self
    }
    override func viewDidAppear(_ animated: Bool) {
        print("OrderOrderViewController viewDidAppear \(OrderOrderViewController.selectViewController)")
        if !Prefs.isUserLogged {
            if LoginViewController.isIgnore {
                onBack("")
                LoginViewController.isIgnore = false
            }else{
                HomeCoordinator.sharedInstance.showLoginScreen()
            }
        }
        if OrderOrderViewController.selectViewController > 0 {
            moveToViewController(at: OrderOrderViewController.selectViewController)
            OrderOrderViewController.selectViewController = -1
        }
        
        if cacheFilter != OrderFilterViewController.orderOrderFilterType {
//            cacheFilter =
            OrderOrderViewController.shared.indexShouldReload.append(contentsOf: [0,1,2,3])
        }
//        OrderOrderViewController.shared.indexShouldReload.append(contentsOf: [0,1,2,3])
        for vc in indexShouldReload {
            listVc[vc].viewDidAppear(false)
        }
        
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
        
        listVc = [child1, child2, child3, child4]
        return listVc
    }

    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {

    }
    @IBAction func onClickFilter(_ sender: Any) {
    }
}
