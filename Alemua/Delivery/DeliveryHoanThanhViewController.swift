//
//  DeliveryHoanThanhViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift

class DeliveryHoanThanhViewController: UIViewController {
    @IBOutlet weak var itemView: ItemView!

    @IBOutlet weak var tfMuatu: AwesomeTextField!
    @IBOutlet weak var tfGiaoden: AwesomeTextField!
    @IBOutlet weak var tfNgay: AwesomeTextField!
    @IBOutlet weak var tfGiaWeb: AwesomeTextField!
    @IBOutlet weak var tfGia: AwesomeTextField!
    @IBOutlet weak var tfNote: AwesomeTextField!
    @IBOutlet weak var rateDetail: RateDetail!
    @IBOutlet weak var review1: ReviewView!
    @IBOutlet weak var review2: ReviewView!
    @IBOutlet weak var danhGia: AwesomeCloseButton!
    
    @IBOutlet weak var lbTongDonHang: UILabel!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    var orderData: ModelOrderClientData!
    let bag = DisposeBag()
    var hoanThanhData: ModelHoanThanhData? {
        didSet {
            if let data = hoanThanhData {
                lbTongDonHang.text = "Tổng đơn hàng (SL: \(orderData.quantity ?? 1))"
                review1.bindData(name: data.userPostName, rating: data.userPostRating, nguoidang: 0)
                review2.bindData(name: data.userShipName, rating: data.userShipRating, nguoidang: 1)
                rateDetail.bindData(RateDetailData(tonggia: data.totalPrice, giamua: data.buyingPrice, discount: data.discount, magiamgia: 0, thue: data.tax, phichuyennoidia: data.transferDomesticFee, phinguoimua: data.transferBuyerFee, phivanchuyenvealemua: data.transferAlemuaFree, phivanchuyenvetaynguoimua: data.transferToBuyerFee, phigiaodichquaalemua: data.transactionAlemuaFree, weight: data.weight))
                if data.userRated != 0 {
                    danhGia.isHidden = true
                }
                if (orderData.transactionOption ?? 0) == 2 {
                    rateDetail.hideForTransactionOption()
                }
                navTitle.title = "Đơn đã hoàn thành - #\(data.id ?? 0)"
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        // Do any additional setup after loading the view.
    }
    func bindData(){
        itemView.bindData(title: orderData.productName!, imageUrl: orderData.photo!, baogia: "\(orderData.quantity!)")
        tfMuatu.text = orderData.buyFrom
        tfGiaoden.text = orderData.deliveryTo
        tfNgay.text = orderData.deliveryDate?.toFormatedDate()
        tfGia.text = "\(orderData.totalPrice ?? 0)".toFormatedPrice()
        tfGiaWeb.text = "\(orderData.webwebsitePrice ?? 0)".toFormatedPrice()
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
                default: break
                }
            }).addDisposableTo(bag)
        
    }

    @IBAction func onShowMoreRateDetail(_ sender: Any) {
        rateDetail.toggleHeight()
    }
    @IBAction func onDanhGia(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showDangChuyenDialog2DaGiao(id: hoanThanhData?.ratingId, userPostName: hoanThanhData?.userPostName, userPostPhoto: hoanThanhData?.userPostPhoto)
    }
}
