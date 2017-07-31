//
//  OrderCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM

protocol DeliveryCoordinatorDelegate {
    func showOrder(_: DeliveryType)
}

class DeliveryCoordinator: Coordinator {
    public static var sharedInstance: DeliveryCoordinator!
    override func start(_ data: Any?) {
        DeliveryCoordinator.sharedInstance = self
    }
}

extension DeliveryCoordinator: DeliveryCoordinatorDelegate {
    func showOrder(_ type: DeliveryType){
        switch type {
        case .BaoGia:
            showBaoGia()
            break
        case .DangChuyen:
            showDangChuyen()
            break
        case .ThanhCong:
            showThanhCong()
            break
        case .DaHuy:
            showDaHuy()
            break
        }
    }
    func showBaoGia() {
        let view: DonMuaViewController = getDonHangStoryboard().instantiateViewController(withClass: DonMuaViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    
    func showDangChuyen() {
        let view: DangChuyenViewController = getDonHangStoryboard().instantiateViewController(withClass: DangChuyenViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    
    func showThanhCong() {
        let view: DeliveryHoanThanhViewController = getDonHangStoryboard().instantiateViewController(withClass: DeliveryHoanThanhViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    
    func showDaHuy() {
        let view: DeliveryDaHuyViewController = getDonHangStoryboard().instantiateViewController(withClass: DeliveryDaHuyViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
}

extension DeliveryCoordinator {
    func showDeliveryDonHang(){
        let view: DonHangViewController = getDonHangStoryboard().instantiateViewController(withClass: DonHangViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    func showThanhToanViewController(){
        let view: ThanhToanViewController = mainStoryboard.instantiateViewController(withClass: ThanhToanViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    func showDeliveryBaoGiaFinal(){
        let view: DeliveryBaoGiaFinalViewController = getDonHangStoryboard().instantiateViewController(withClass: DeliveryBaoGiaFinalViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    func showFilter(){
        let view: DeliveryFilterViewController = getDonHangStoryboard().instantiateViewController(withClass: DeliveryFilterViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    
}



