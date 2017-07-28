//
//  OrderCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM

protocol OrderCoordinatorDelegate {
    func showDonMua()
    func showDonHang()
    func showDangChuyen()
    func showDaMua()
    func showOrder(_: OrderType)
}

class OrderCoordinator: Coordinator {
    public static var sharedInstance: OrderCoordinator!
    override func start(_ data: Any?) {
        OrderCoordinator.sharedInstance = self
        OrderOrderCoordinator(navigation).start(nil)
    }
}

extension OrderCoordinator: OrderCoordinatorDelegate {
    func showOrder(_ type: OrderType){
        switch type {
        case .DonMua:
            showDonMua()
            break
        case .BaoGia:
            showDonHang()
            break
        case .DangChuyen:
            showDangChuyen()
            break
        case .DaMua:
            showDaMua()
            break
        }
    }
    func showDonMua() {
        let view: DonMuaViewController = getDonHangStoryboard().instantiateViewController(withClass: DonMuaViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    
    func showDonHang() {
        let view: DonHangViewController = getDonHangStoryboard().instantiateViewController(withClass: DonHangViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    
    func showDangChuyen() {
        let view: DangChuyenViewController = getDonHangStoryboard().instantiateViewController(withClass: DangChuyenViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    
    func showDaMua() {
        let view: DaMuaViewController = getDonHangStoryboard().instantiateViewController(withClass: DaMuaViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
}


extension OrderCoordinator {
    func showTaoDonHang(){
        let view: OrderTaoDonMuaViewController = mainStoryboard.instantiateViewController(withClass: OrderTaoDonMuaViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    func showOrderTabAfterFinishTaoDonHang(){
        navigation?.popViewController(animated: false)
        navigation?.popViewController(animated: false)
    }
}
