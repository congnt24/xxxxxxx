//
//  DeliveryViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/24/17.
//  Copyright © 2017 cong. All rights reserved.
//
import UIKit
import XLPagerTabStrip

enum DeliveryType: Int {
    case BaoGia = 1
    case DangChuyen = 2
    case ThanhCong = 3
    case DaHuy = 4
}
class DeliveryOrderViewController: ButtonBarPagerTabStripViewController {

    public static var defaultTab = 0
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
        child1.deliveryType = .BaoGia
        child2.deliveryType = .DangChuyen
        child3.deliveryType = .ThanhCong
        child4.deliveryType = .DaHuy

        return [child1, child2, child3, child4]
    }
    override func viewWillAppear(_ animated: Bool) {
        //change to default index
        if !Prefs.isUserLogged {
            if LoginViewController.isIgnore {
                onBack("")
                LoginViewController.isIgnore = false
            }else{
                HomeCoordinator.sharedInstance.showLoginScreen()
            }
        }
        moveToViewController(at: DeliveryOrderViewController.defaultTab)
    }
    

    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {

    }
    @IBAction func onClickFilter(_ sender: Any) {
    }
    
    @IBAction func onBack(_ sender: Any) {
        if HomeViewController.homeType == .order {
            OrderNavTabBarViewController.sharedInstance.switchTab(index: 0)
        }else{
            DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 0)
        }
    }
}
