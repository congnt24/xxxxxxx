//
//  OrderOrderCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//


import UIKit
import AwesomeMVVM

class OrderOrderCoordinator: Coordinator {
    public static var sharedInstance: OrderOrderCoordinator!
    override func start(_ data: Any?) {
        OrderOrderCoordinator.sharedInstance = self
    }
}

extension OrderOrderCoordinator {
    func showBaoGiaDetail(data: ModelOrderBaoGiaData, orderData: ModelOrderClientData){
        let view: OrderBaoGiaDetailSubViewController = getDonHangStoryboard().instantiateViewController(withClass: OrderBaoGiaDetailSubViewController.self)
        view.modelOrderBaoGia = data
        view.orderData = orderData
        navigation?.pushViewController(view, animated: true)
    }
    
    func showBaoGiaDetailDialog1(id: Int?, quoteId: Int?, transaction_option: Int?) {
        let view = UIStoryboard(name: "DonHang", bundle: nil).instantiateViewController(withIdentifier: "OrderDialogBaoGia1ViewController") as! OrderDialogBaoGia1ViewController
        view.order_id = id!
        view.quoteId = quoteId!
        view.transaction_option = transaction_option ?? 1
        AwesomeDialog.shared.show(vc: navigation?.topViewController, popupVC: view)
    }
    
    
    func showBaoGiaDetailDialog2(index: Int, id: Int?, quoteId: Int?) {
        if index == 0 {
            let view = UIStoryboard(name: "DonHang", bundle: nil).instantiateViewController(withIdentifier: "OrderDialogBaoGia2ViewController") as! OrderDialogBaoGia2ViewController
            view.order_id = id!
            view.quoteId = quoteId!
            AwesomeDialog.shared.show(vc: navigation?.topViewController, popupVC: view)
        } else{
            let view = UIStoryboard(name: "DonHang", bundle: nil).instantiateViewController(withIdentifier: "OrderDialogBaoGia4ViewController") as! OrderDialogBaoGia4ViewController
            view.order_id = id!
            view.quoteId = quoteId!
            AwesomeDialog.shared.show(vc: navigation?.topViewController, popupVC: view)
        }
    }
    
    func showBaoGiaDetailDialog3(id: Int?, quoteId: Int?) {
        let view = UIStoryboard(name: "DonHang", bundle: nil).instantiateViewController(withIdentifier: "OrderDialogBaoGia3ViewController") as! OrderDialogBaoGia3ViewController
        view.order_id = id!
        view.quoteId = quoteId!
        AwesomeDialog.shared.show(vc: navigation?.topViewController, popupVC: view)
    }
    
    
}

extension OrderOrderCoordinator {
    func showDangChuyenDialog1BaoXau(modelDangChuyen: ModelDonHangDangChuyenData){
        let view = UIStoryboard(name: "DonHang", bundle: nil).instantiateViewController(withIdentifier: "OrderDialogDangChuyen1ViewController") as! OrderDialogDangChuyen1ViewController
        view.user_post_id = modelDangChuyen.userPostId
        view.sdt = modelDangChuyen.userShipPhone
        view.name = modelDangChuyen.userShipName
        AwesomeDialog.shared.show(vc: navigation?.topViewController, popupVC: view)
    }
    func showDangChuyenDialog2DaGiao(id: Int?){
        let view: OrderDialogDangChuyen2ViewController = getDonHangStoryboard().instantiateViewController(withClass: OrderDialogDangChuyen2ViewController.self)
        view.ratingId = id
        navigation?.pushViewController(view, animated: true)
//        AwesomeDialog.shared.show(vc: navigation?.topViewController, name: "DonHang", identify: "OrderDialogDangChuyen2ViewController")
    }
    func showDangChuyenDialog3HuyDon(orderId: Int?){
        let view = UIStoryboard(name: "DonHang", bundle: nil).instantiateViewController(withIdentifier: "OrderDialogDangChuyen3ViewController") as! OrderDialogDangChuyen3ViewController
        view.orderId = orderId!
        AwesomeDialog.shared.show(vc: navigation?.topViewController, popupVC: view)}
}
