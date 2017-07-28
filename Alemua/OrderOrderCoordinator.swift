//
//  OrderOrderCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//


import UIKit
import AwesomeMVVM

protocol OrderOrderCoordinatorDelegate {
    func showBaoGiaDetail()
}

class OrderOrderCoordinator: Coordinator {
    public static var sharedInstance: OrderOrderCoordinator!
    override func start(_ data: Any?) {
        OrderOrderCoordinator.sharedInstance = self
    }
}

extension OrderOrderCoordinator {
    func showBaoGiaDetail(){
        let view: OrderBaoGiaDetailSubViewController = getDonHangStoryboard().instantiateViewController(withClass: OrderBaoGiaDetailSubViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
    
    func showBaoGiaDetailDialog1() {
        AwesomeDialog.shared.show(vc: navigation?.topViewController, name: "DonHang", identify: "OrderDialogBaoGia1ViewController")
    }
    
    
    func showBaoGiaDetailDialog2(index: Int) {
        if index == 0 {
            AwesomeDialog.shared.show(vc: navigation?.topViewController, name: "DonHang", identify: "OrderDialogBaoGia2ViewController")
        } else{
            AwesomeDialog.shared.show(vc: navigation?.topViewController, name: "DonHang", identify: "OrderDialogBaoGia4ViewController")
        }
    }
    
    func showBaoGiaDetailDialog3() {
        AwesomeDialog.shared.show(vc: navigation?.topViewController, name: "DonHang", identify: "OrderDialogBaoGia3ViewController")
    }
}

extension OrderOrderCoordinator {
    func showDangChuyenDialog1BaoXau(){
        AwesomeDialog.shared.show(vc: navigation?.topViewController, name: "DonHang", identify: "OrderDialogDangChuyen1ViewController")
    }
    func showDangChuyenDialog2DaGiao(){
        let view: OrderDialogDangChuyen2ViewController = getDonHangStoryboard().instantiateViewController(withClass: OrderDialogDangChuyen2ViewController.self)
        navigation?.pushViewController(view, animated: true)
//        AwesomeDialog.shared.show(vc: navigation?.topViewController, name: "DonHang", identify: "OrderDialogDangChuyen2ViewController")
    }
    func showDangChuyenDialog3HuyDon(){
        AwesomeDialog.shared.show(vc: navigation?.topViewController, name: "DonHang", identify: "OrderDialogDangChuyen3ViewController")
    }
}
