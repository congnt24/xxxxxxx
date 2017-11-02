//
//  DaMuaViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift

class DaMuaViewController: UIViewController {
    @IBOutlet weak var itemView: ItemView!

    @IBOutlet weak var tfMuatu: AwesomeTextField!
    @IBOutlet weak var tfGiaoden: AwesomeTextField!
    @IBOutlet weak var tfNgay: AwesomeTextField!
    @IBOutlet weak var tfGia: AwesomeTextField!
    @IBOutlet weak var tfGiaWeb: AwesomeTextField!
    @IBOutlet weak var uiMoreDetail: RateDetail!
    @IBOutlet weak var review1: ReviewView!
    @IBOutlet weak var review2: ReviewView!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBOutlet weak var lbTongDonHang: UILabel!
    
    let bag = DisposeBag()
    var orderData: ModelOrderClientData!
    var hoanThanhData: ModelHoanThanhData? {
        didSet {
            if let data = hoanThanhData {
                review1.bindData(name: data.userPostName, rating: data.userPostRating, nguoidang: 0)
                review2.bindData(name: data.userShipName, rating: data.userShipRating, nguoidang: 1)
                uiMoreDetail.setupRateDetailForMuaHang(RateDetailData(tonggia: data.totalPrice, giamua: data.buyingPrice,  discount: data.discount, magiamgia: data.promotion_money, thue: data.tax, phichuyennoidia: data.transferDomesticFee, phinguoimua: data.transferBuyerFee, phivanchuyenvealemua: data.transferAlemuaFree, phivanchuyenvetaynguoimua: data.transferToBuyerFee, phigiaodichquaalemua: data.transactionAlemuaFree, weight: data.weight))
                tfGia.text = "\(data.totalPrice ?? 0)".toFormatedPrice()
//                if (orderData.transactionOption ?? 0) == 2 {
//                    uiMoreDetail.hideForTransactionOption()
//                }
                
                lbTongDonHang.text = "Tổng đơn hàng (SL: \(orderData.numberProduct ?? 1))"
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            bindData()
        // Do any additional setup after loading the view.
        
        navTitle.title = "Đơn hàng đã mua - #\(orderData.id ?? 0)"
    }
    
    func bindData(){
        itemView.bindData(title: orderData.productName!, imageUrl: orderData.photo!, baogia: "\(orderData.quantity!)")
        tfMuatu.text = orderData.buyFrom
        tfGiaoden.text = orderData.deliveryTo
        tfNgay.text = orderData.deliveryDate?.toFormatedDate()
        tfGia.text = "\(orderData.websitePrice ?? 0)".toFormatedPrice()
        tfGiaWeb.text = "\(orderData.websitePrice ?? 0)".toFormatedPrice()
        
        AlemuaApi.shared.aleApi.request(AleApi.getOrderDetails(orderType: 3, orderId: orderData.id!))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    self.hoanThanhData = ModelHoanThanhData(json: result)
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
        
    }
    
    @IBAction func onMoreDetail(_ sender: Any) {
        uiMoreDetail.toggleHeight()
    }
}
