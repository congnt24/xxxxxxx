//
//  DeliveryDaHuyViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift

class DeliveryDaHuyViewController: UIViewController {
    @IBOutlet weak var itemView: ItemView!

    @IBOutlet weak var tfMuatu: AwesomeTextField!
    @IBOutlet weak var tfGiaoden: AwesomeTextField!
    @IBOutlet weak var tfNgay: AwesomeTextField!
    @IBOutlet weak var tfGia: AwesomeTextField!
    @IBOutlet weak var tfLydo: AwesomeTextField!
    @IBOutlet weak var tfGhichu: AwesomeTextField!
    @IBOutlet weak var rateDetail: RateDetail!
    @IBOutlet weak var review: ReviewView!
    
    
    var orderData: ModelOrderClientData!
    let bag = DisposeBag()
    var dahuyData: ModelHoanThanhData? {
        didSet {
            if let data = dahuyData {
                review.bindData(name: data.userPostName, rating: data.userPostRating, nguoidang: 0)
                
                itemView.bindData(title: data.productName, imageUrl: data.photo, baogia: "\(0)")
                
                rateDetail.bindData(RateDetailData(tonggia: data.totalPrice, giamua: data.buyingPrice, discount: data.discount, magiamgia: 0, thue: data.tax, phichuyennoidia: data.transferDomesticFee, phinguoimua: data.transferBuyerFee, phivanchuyenvealemua: data.transferAlemuaFree, phivanchuyenvetaynguoimua: data.transferToBuyerFee, phigiaodichquaalemua: data.transactionAlemuaFree, weight: data.weight))

                //
//                rateDetail.bindData(RateDetailData(tonggia: orderData.totalPrice,giamua: 0, discount: 0, magiamgia: 0, thue: orderData.tax, phichuyennoidia: orderData.transferDomesticFee, phinguoimua: orderData.transferBuyerFee, phivanchuyenvealemua: orderData.transferAlemuaFree, phivanchuyenvetaynguoimua: orderData.transferToBuyerFee, phigiaodichquaalemua: orderData.transactionAlemuaFree))
                tfMuatu.text = data.buyFrom
                tfNgay.text = data.deliveryDate?.toFormatedDate()
                tfGia.text = "\(orderData.totalPrice ?? 0)".toFormatedPrice()
                tfLydo.text = data.cancelReason
                tfGhichu.text = data.note
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AlemuaApi.shared.aleApi.request(AleApi.getOrderDetails(orderType: 5, orderId: orderData.id!))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    self.dahuyData = ModelHoanThanhData(json: result)
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }


    @IBAction func onShowModeRateDetail(_ sender: Any) {
        rateDetail.toggleHeight()
    }
}
