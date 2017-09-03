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
    
    
    var orderData: ModelOrderClientData!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        // Do any additional setup after loading the view.
    }
    func bindData(){
        itemView.bindData(title: orderData.productName, imageUrl: orderData.photo, baogia: "\(orderData.quantity!)")
        lbMuaTu.text = orderData.buyFrom
        lbGiaoDen.text = orderData.deliveryTo
        lbNgay.labelLeft = orderData.deliveryDate?.toFormatedDate() ?? ""
        lbGiaTrenWeb.text = "\(orderData.websitePrice!)".toFormatedPrice()
        lbMau.text = orderData.productDescription
        lbLuaChon.text = "\(orderData.productOption!.toProductOptionName())"
    }

}
