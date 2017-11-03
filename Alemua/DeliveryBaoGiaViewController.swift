//
//  DonMuaViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import SwiftyJSON
import RxSwift

class DeliveryBaoGiaViewController: UIViewController {
    
    @IBOutlet weak var itemView: ItemView!
    @IBOutlet weak var lbMuaTu: AwesomeTextField!
    @IBOutlet weak var lbGiaoDen: AwesomeTextField!
    @IBOutlet weak var lbNgay: AwesomeTextField!
    @IBOutlet weak var lbGiaTrenWeb: AwesomeTextField!
    @IBOutlet weak var lbGia: AwesomeTextField!
    @IBOutlet weak var lbMau: AwesomeTextField!
    @IBOutlet weak var lbLuaChon: AwesomeTextField!
    @IBOutlet weak var rateDetail: RateDetail!
    @IBOutlet weak var lbTongGia: UILabel!
    @IBOutlet weak var lbTongGiaWeb: UILabel!
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    var orderData: ModelOrderClientData!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        itemView.hideBaoGia()
        rateDetail.bindData(RateDetailData(tonggia: orderData.totalPrice, giamua: orderData.buyingPrice ?? 0, discount: orderData.discount, magiamgia: orderData.promotion_money, thue: orderData.tax, phichuyennoidia: orderData.transferDomesticFee, phinguoimua: orderData.transferBuyerFee, phivanchuyenvealemua: orderData.transferAlemuaFree, phivanchuyenvetaynguoimua: orderData.transferToBuyerFee, phigiaodichquaalemua: orderData.transaction_alemua_free, weight: orderData.weight))
//
        if (orderData.transactionOption ?? 0) == 2 {
            rateDetail.hideForTransactionOption()
        }
        if HomeViewController.homeType == .delivery {
            navTitle.title = "Chi tiết báo giá - #\(orderData.id ?? 0)"
        }
        // Do any additional setup after loading the view.
    }
    func bindData(){
        itemView.bindData(title: orderData.productName, imageUrl: orderData.photo, baogia: "\(orderData.quotes?.count ?? 0)")
        lbMuaTu.text = orderData.buyFrom
        lbGiaoDen.text = orderData.deliveryTo
        lbNgay.labelLeft = orderData.deliveryDate?.toFormatedDate() ?? ""
        lbGiaTrenWeb.text = "\(orderData.webwebsitePrice!)".toFormatedPrice()
        lbGia.text = "\(orderData.totalPrice!)".toFormatedPrice()
        lbTongGia.text = "Tổng đơn hàng (SL: \(orderData.quantity ?? 1))"
        lbMau.text = orderData.productDescription
        lbLuaChon.text = (orderData.productOption ?? "").splitted(by: ",").map { Int($0)!.toProductOptionName() }.joined(separator: ", ")
        
    }
    
    @IBOutlet weak var onShowMoew: AwesomeToggleButton!
    @IBAction func onShowMore(_ sender: Any) {
        rateDetail.toggleHeight()
    }
    func fetchDetail(){
        
    }
    
}

