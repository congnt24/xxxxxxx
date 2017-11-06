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
    func showOrder(_: DeliveryType, data: ModelOrderClientData)
}

class DeliveryCoordinator: Coordinator {
    public static var sharedInstance: DeliveryCoordinator!
    override func start(_ data: Any?) {
        DeliveryCoordinator.sharedInstance = self
    }
}

extension DeliveryCoordinator: DeliveryCoordinatorDelegate {
    func showOrder(_ type: DeliveryType, data: ModelOrderClientData){
        switch type {
        case .BaoGia:
            showBaoGia(data)
            break
        case .DangChuyen:
            showDangChuyen(data)
            break
        case .ThanhCong:
            showThanhCong(data)
            break
        case .DaHuy:
            showDaHuy(data)
            break
        }
    }
    func showBaoGia(_ data: ModelOrderClientData) {
        let view: DeliveryBaoGiaViewController = getDonHangStoryboard().instantiateViewController(withClass: DeliveryBaoGiaViewController.self)
        view.orderData = data
        navigation?.pushViewController(view, animated: true)
    }
    
    func showDangChuyen(_ data: ModelOrderClientData) {
        let view: DangChuyenViewController = getDonHangStoryboard().instantiateViewController(withClass: DangChuyenViewController.self)
        view.orderData = data
        navigation?.pushViewController(view, animated: true)
    }
    
    func showThanhCong(_ data: ModelOrderClientData) {
        let view: DeliveryHoanThanhViewController = getDonHangStoryboard().instantiateViewController(withClass: DeliveryHoanThanhViewController.self)
        view.orderData = data
        navigation?.pushViewController(view, animated: true)
    }
    
    func showDaHuy(_ data: ModelOrderClientData) {
        let view: DeliveryDaHuyViewController = getDonHangStoryboard().instantiateViewController(withClass: DeliveryDaHuyViewController.self)
        view.orderData = data
        navigation?.pushViewController(view, animated: true)
    }
}

extension DeliveryCoordinator {
    func showDeliveryDonHang(data: ModelQuoteData){
        let view: DonHangViewController = getDonHangStoryboard().instantiateViewController(withClass: DonHangViewController.self)
        view.modelQuoteData = data
        navigation?.pushViewController(view, animated: true)
    }
    func showThanhToanViewController(){
        let view: ThanhToanViewController = mainStoryboard.instantiateViewController(withClass: ThanhToanViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    func showDeliveryBaoGiaFinal(data: ModelOrderClientData){
        let view: DeliveryBaoGiaFinalViewController = getDonHangStoryboard().instantiateViewController(withClass: DeliveryBaoGiaFinalViewController.self)
        view.modelQuoteData = data
        navigation?.pushViewController(view, animated: true)
    }
    func showFilter(){
        let view: DeliveryFilterViewController = getDonHangStoryboard().instantiateViewController(withClass: DeliveryFilterViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    func showFilter2(){
        let view: DeliveryFilter2ViewController = mainStoryboard.instantiateViewController(withClass: DeliveryFilter2ViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    
    func showDanhSachKH(){
        let view: DanhSachKHViewController = mainStoryboard.instantiateViewController(withClass: DanhSachKHViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    func showThuNhap(){
        let view: DeliveryIncomeViewController = getProfileStoryboard().instantiateViewController(withClass: DeliveryIncomeViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    func showLichSuMuaHang(){
        let view: DeliveryIncomeViewController = getProfileStoryboard().instantiateViewController(withClass: DeliveryIncomeViewController.self)
        view.type = 2
        navigation?.pushViewController(view, animated: true)
    }
    
}



