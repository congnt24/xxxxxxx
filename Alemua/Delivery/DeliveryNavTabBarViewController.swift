//
//  DeliveryNavTabBarViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/24/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import RxSwift

class DeliveryNavTabBarViewController: UITabBarController {
    let bag = DisposeBag()
    var defaultTab = 0
    var showThanhToan = false
    
    public static var sharedInstance: DeliveryNavTabBarViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        DeliveryNavTabBarViewController.sharedInstance = self
        // Do any additional setup after loading the view.
        fetchUnreadNoti()
        switchTab(index: defaultTab)
        if showThanhToan {
            showThongTinThanhToan()
            showThanhToan = false
        }
    }
    
    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if SingleDeliveryViewController.shouldReloadPage > -1 {
//            DeliveryOrderViewController.shared.listVC[0].reloadPage()
            SingleDeliveryViewController.shouldReloadPage = -1
        }
    }
    
    
    func switchTab(index: Int){
        selectedIndex = index
    }
    
    func fetchUnreadNoti(){
        
        AlemuaApi.shared.aleApi.request(AleApi.getUnreadNotification(isShipper: HomeViewController.homeType == .order ? 0 : 1))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    let unread = result["number_unread"].int ?? 0
                    if unread == 0 {
                        self.tabBar.items![3].badgeValue = nil
                    }else{
                        self.tabBar.items![3].badgeValue = "\(unread)"
                    }
                    //                    self.tabBar.items
                    //                    NotifyViewController.shared.notifyBar.badgeValue = "\(unread)"
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                default: break
                }
            }).addDisposableTo(bag)
    }
    
    func showThongTinThanhToan(){
        DeliveryCoordinator.sharedInstance.showThanhToanViewController()
    }
}
