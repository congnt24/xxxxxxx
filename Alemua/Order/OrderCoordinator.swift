//
//  OrderCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM


class OrderCoordinator: Coordinator {
    public static var sharedInstance: OrderCoordinator!
    override func start(_ data: Any?) {
        OrderCoordinator.sharedInstance = self
        OrderOrderCoordinator(navigation).start(nil)
    }
}

extension OrderCoordinator {
    func showOrder(_ type: OrderType, data: ModelOrderClientData){
        switch type {
        case .DonMua:
            showDonMua(data)
            break
        case .BaoGia:
            showDonHang(data)
            break
        case .DangChuyen:
            showDangChuyen(data)
            break
        case .DaMua:
            showDaMua(data)
            break
        }
    }
    func showDonMua(_ data: ModelOrderClientData) {
        let view: DonMuaViewController = getDonHangStoryboard().instantiateViewController(withClass: DonMuaViewController.self)
        view.orderData = data
        navigation?.pushViewController(view, animated: true)
    }
    
    func showDonHang(_ data: ModelOrderClientData) {
        let view: DonHangViewController = getDonHangStoryboard().instantiateViewController(withClass: DonHangViewController.self)
        view.orderData = data
        navigation?.pushViewController(view, animated: true)
    }
    
    func showDangChuyen(_ data: ModelOrderClientData) {
        let view: DangChuyenViewController = getDonHangStoryboard().instantiateViewController(withClass: DangChuyenViewController.self)
        view.orderData = data
        navigation?.pushViewController(view, animated: true)
    }
    
    func showDaMua(_ data: ModelOrderClientData) {
        let view: DaMuaViewController = getDonHangStoryboard().instantiateViewController(withClass: DaMuaViewController.self)
        view.orderData = data
        navigation?.pushViewController(view, animated: true)
    }
    
    
    func showOrderSelectMap() {
        let view: TaoDonHangSelectMapViewController = mainStoryboard.instantiateViewController(withClass: TaoDonHangSelectMapViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    
}


extension OrderCoordinator {
    func showTaoDonHang(data: ModelOrderData?, text: String? = nil){
        let view: OrderTaoDonMuaViewController = mainStoryboard.instantiateViewController(withClass: OrderTaoDonMuaViewController.self)
        if let text = text {
            view.parentUrl = text
        }
        if let data = data {
            view.orderData = data
        }
        
        navigation?.pushViewController(view, animated: true)
    }
    func showOrderTabAfterFinishTaoDonHang(){
        navigation?.popViewController(animated: false)
        navigation?.popViewController(animated: false)
    }
    
    func showSanPhamHot(section: String){
        let view: OrderMain2ViewController = mainStoryboard.instantiateViewController(withClass: OrderMain2ViewController.self)
        view.sectionName = section
        navigation?.pushViewController(view, animated: true)
    }
    
    func showFilter(){
        let view: OrderFilterViewController = getDonHangStoryboard().instantiateViewController(withClass: OrderFilterViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    
    func showTaoDonHang(url: String!, data: ModelOrderData?){
        
        let view: TaoDonHangViewController = mainStoryboard.instantiateViewController(withClass: TaoDonHangViewController.self)
        view.website_url = url
        view.data = data
        navigation?.pushViewController(view, animated: true)
    }
}
