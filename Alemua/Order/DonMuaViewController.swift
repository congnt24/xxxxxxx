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

class DonMuaViewController: UIViewController {

    @IBOutlet weak var itemView: ItemView!
    @IBOutlet weak var lbMuaTu: AwesomeTextField!
    @IBOutlet weak var lbGiaoDen: AwesomeTextField!
    @IBOutlet weak var lbNgay: AwesomeTextField!
    @IBOutlet weak var lbGiaTrenWeb: AwesomeTextField!
    @IBOutlet weak var lbMau: AwesomeTextField!
    @IBOutlet weak var lbLuaChon: AwesomeTextField!
    @IBOutlet weak var lbThongDonHang: UILabel!
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    var orderData: ModelOrderClientData!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        
        if HomeViewController.homeType == .delivery {
            navTitle.title = "Chi tiết báo giá - #\(orderData.id ?? 0)"
        }else{
            navTitle.title = "Đơn mua - #\(orderData.id ?? 0)"
        }
        // Do any additional setup after loading the view.
    }
    func bindData(){
        itemView.bindData(title: orderData.productName, imageUrl: orderData.photo, baogia: "\(orderData.quotes?.count ?? 0)")
        lbMuaTu.text = orderData.buyFrom
        lbGiaoDen.text = orderData.deliveryTo
        lbNgay.labelLeft = orderData.deliveryDate?.toFormatedDate() ?? ""
        lbGiaTrenWeb.text = "\(orderData.websitePrice!)".toFormatedPrice()
        lbMau.text = orderData.productDescription
        lbLuaChon.text = (orderData.productOption ?? "").splitted(by: ",").map { Int($0)!.toProductOptionName() }.joined(separator: ", ")
        lbThongDonHang.text = "Giá trên web (SL: \(orderData.quantity ?? 1))"
    }

}
