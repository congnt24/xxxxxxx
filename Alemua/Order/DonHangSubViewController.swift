//
//  DonHangSubViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/23/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import AwesomeMVVM

class DonHangSubViewController: UIViewController, IndicatorInfoProvider {
    var modelQuoteData: ModelQuoteData?
    var orderData: ModelOrderClientData? {
        didSet {
            if let orderData = orderData {
                //bind data
                itemView.bindData(title: orderData.productName!, imageUrl: orderData.photo!, baogia: "\(orderData.quotes!.count)")
                lbMuaTu.text = orderData.buyFrom
                lbGiaoDen.text = orderData.deliveryTo
                lbNgay.labelLeft = orderData.deliveryDate?.toFormatedDate() ?? ""
                lbGia.text = "\(orderData.websitePrice ?? 0)".toFormatedPrice()
                lbMota.text = orderData.note
                lbLuaChon.text = orderData.productDescription
            }
        }
    }
    @IBOutlet weak var btnDeliveryBaoGia: AwesomeCloseButton!

    @IBOutlet weak var itemView: ItemView!
    @IBOutlet weak var lbMuaTu: AwesomeTextField!
    @IBOutlet weak var lbGiaoDen: AwesomeTextField!
    @IBOutlet weak var lbNgay: AwesomeTextField!
    @IBOutlet weak var lbGia: AwesomeTextField!
    @IBOutlet weak var lbMota: AwesomeTextField!
    @IBOutlet weak var lbLuaChon: AwesomeTextField!



    var itemInfo: IndicatorInfo!
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        if let modelQuoteData = modelQuoteData {
//            //bind data
//            itemView.bindData(title: modelQuoteData.productName!, imageUrl: modelQuoteData.photo!, baogia: "\(modelQuoteData.websitePrice!)")
//            lbMuaTu.text = modelQuoteData.buyFrom
//            lbGiaoDen.text = modelQuoteData.deliveryTo
//            lbNgay.placeholder = modelQuoteData.deliveryDate
//            lbGia.text = "\(modelQuoteData.websitePrice!)"
//            lbMota.text = modelQuoteData.note
//            lbLuaChon.text = modelQuoteData.productDescription
//        }
//        if let orderData = orderData {
//            //bind data
//            itemView.bindData(title: orderData.productName!, imageUrl: orderData.photo!, baogia: "\(orderData.websitePrice!)")
//            lbMuaTu.text = orderData.buyFrom
//            lbGiaoDen.text = orderData.deliveryTo
//            lbNgay.placeholder = orderData.deliveryDate
//            lbGia.text = "\(orderData.websitePrice!)"
//            lbMota.text = orderData.note
//            lbLuaChon.text = orderData.productDescription
//        }

    }
    override func viewWillAppear(_ animated: Bool) {
        if HomeViewController.homeType == .order {
            btnDeliveryBaoGia.isHidden = true
        } else {
            btnDeliveryBaoGia.isHidden = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {

    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        guard itemInfo != nil else {
            return IndicatorInfo(title: "Tab0")
        }
        return itemInfo
    }

    @IBAction func onClickDeliveryBaoGia(_ sender: Any) {
        //TODO: Check if not logged -> Login else  if chọn chỉ mua khi có giảm giá -> Dialog -> DeliveryBaoGiaFinalViewController
//        AwesomeDialog.shared.show(vc: self, name: "DonHang", identify: "DeliveryDialogBaoGiaViewController")

        if Prefs.isUserLogged {
            if orderData?.productOption == 3 { // chir mua khi có giảm giá
                DeliveryDialogBaoGiaViewController.orderData = orderData
                AwesomeDialog.shared.show(vc: self, name: "DonHang", identify: "DeliveryDialogBaoGiaViewController")
            }else{
                DeliveryCoordinator.sharedInstance.showDeliveryBaoGiaFinal(data: orderData!)
            }
        } else {
            HomeCoordinator.sharedInstance.showLoginScreen()
        }

    }

}
