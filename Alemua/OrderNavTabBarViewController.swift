//
//  NavTabBarViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class OrderNavTabBarViewController: UITabBarController {
    var notiNavigate: Any?
    var defaultTab = 0
    
    
    let bag = DisposeBag()
    public static var sharedInstance: OrderNavTabBarViewController!
    @IBOutlet weak var navItems: UINavigationItem!
    var coordinator: OrderNavTabBarCoordinator!
    override func viewDidLoad() {
        super.viewDidLoad()
        OrderNavTabBarViewController.sharedInstance = self
        
        // Do any additional setup after loading the view.
        fetchUnreadNoti()
        
        switchTab(index: defaultTab)
        
    }
    
    func switchTab(index: Int){
        selectedIndex = index
    }
    
    func reduceNoti(){
//        let x = Int(self.tabBar.items![3].badgeValue ?? "0")
//        self.tabBar.items![3].badgeValue = "\(x-1)"
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
}
