//
//  DeliveryBaoGiaFinalViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/28/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxCocoa
import RxSwift
import SwiftyJSON

class DeliveryBaoGiaFinalViewController: UIViewController {
    @IBOutlet weak var itemView: ItemView!
    var modelQuoteData: ModelOrderClientData!
    var req = CreateQuoteRequest()
    var bag = DisposeBag()

    @IBOutlet weak var tfMuatu: AwesomeTextField!
    @IBOutlet weak var tfGiaoden: AwesomeTextField!
    @IBOutlet weak var tfNgay: AwesomeTextField!
    @IBOutlet weak var tfGia: AwesomeTextField!
    @IBOutlet weak var tfMota: AwesomeTextField!
    @IBOutlet weak var tfNote: AwesomeTextField!
    @IBOutlet weak var rateDetail: RateDetail!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DeliveryBaoGiaFinalViewController")

        itemView.bindData(title: modelQuoteData.productName, imageUrl: modelQuoteData.photo, baogia: "\(modelQuoteData.quotes?.count ?? 0)")
        tfMuatu.text = modelQuoteData.buyFrom
        tfGiaoden.text = modelQuoteData.deliveryTo
        tfNgay.text = modelQuoteData.deliveryDate?.toFormatedDate()
        tfGia.text = "\(modelQuoteData.websitePrice! + modelQuoteData.transaction_alemua_free!)".toFormatedPrice()
        tfMota.text = modelQuoteData.productDescription
        tfNote.text = modelQuoteData.note
        
        if modelQuoteData.productOption == 4 {
            rateDetail.showGiamGia()
        }
//        let rate = RateDetailData()
        
//        AlemuaApi.shared.aleApi.request(AleApi.getOrderDetails(orderType: 1, orderId: self.modelQuoteData.id!))
//            .toJSON()
//            .subscribe(onNext: { (res) in
//                switch res {
//                case .done(let result, _):
//                    let orderDetail = ModelOrderBaoGiaData(json: result)
//                    self.rateDetail.bindData(order: orderDetail)
//                    print("Cancel success")
//                    break
//                case .error(let msg):
//                    print("Error \(msg)")
//                    break
//                default: break
//                }
//            }).addDisposableTo(bag)
        
        rateDetail.enableEditing()
        rateDetail.onPriceChange = { (price) in
            if let price = price {
                self.tfGia.text = "\(price)".toFormatedPrice()
            }
        }
        rateDetail.tonggia.text = "\(modelQuoteData.websitePrice ?? 0)"
        rateDetail.rateData.tonggia = modelQuoteData.websitePrice ?? 0
        rateDetail.phigiaodichquaalemua.text = "\(modelQuoteData.transaction_alemua_free ?? 0)"
        rateDetail.rateData.phigiaodichquaalemua = modelQuoteData.transaction_alemua_free ?? 0
        
        
        req.buyFrom = modelQuoteData.buyFrom
        req.deliveryDate = modelQuoteData.deliveryDate
        req.deliveryTo = modelQuoteData.deliveryTo
//        req.totalPrice = modelQuoteData.websitePrice
        req.descriptionValue = modelQuoteData.productDescription
        req.note = modelQuoteData.note
        req.orderId = modelQuoteData.id
    }

    @IBAction func onShowMoreRateDetail(_ sender: Any) {
        rateDetail.toggleHeight()
    }
    @IBAction func onFinishBaoGia(_ sender: Any) {
        req.totalPrice = rateDetail.rateData.tonggia
        req.tax = rateDetail.rateData.thue
        req.buyingPrice = rateDetail.rateData.phinguoimua
        req.transferAlemuaFree = rateDetail.rateData.phivanchuyenvealemua
        req.transferBuyerFee = rateDetail.rateData.phigiaodichquaalemua
        req.transferToBuyerFee = rateDetail.rateData.phivanchuyenvetaynguoimua
        req.transferDomesticFee = rateDetail.rateData.phichuyennoidia
        AlemuaApi.shared.aleApi.request(.createQuote(quote: req))
            .toJSON()
            .catchError({ (error) -> Observable<AleResult> in
                return Observable.just(AleResult.error(msg: "Invalid params"))
            })
            .subscribe(onNext: { (res) in
                switch res {
                case .done( _):
//                    OrderOrderCoordinator.sharedInstance.showDangChuyenDialog2DaGiao(id: 0)
                    AppCoordinator.sharedInstance.navigation?.popToViewController(DeliveryNavTabBarViewController.sharedInstance, animated: true)
                    print("Cancel success")
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }
}
