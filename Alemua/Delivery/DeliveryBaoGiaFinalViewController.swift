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

        itemView.bindData(title: modelQuoteData.productName, imageUrl: modelQuoteData.photo, baogia: "\(modelQuoteData.numberProduct ?? 0)")
        tfMuatu.text = modelQuoteData.buyFrom
        tfGiaoden.text = modelQuoteData.deliveryTo
        tfNgay.text = modelQuoteData.deliveryDate?.toFormatedDate()
        tfGia.text = "\(modelQuoteData.websitePrice!)".toFormatedPrice()
        tfMota.text = modelQuoteData.productDescription
        tfNote.text = modelQuoteData.note
        
        rateDetail.enableEditing()
        rateDetail.onPriceChange = { (price) in
            if let price = price {
                self.tfGia.text = "\(price)".toFormatedPrice()
            }
        }
        
        
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
                    OrderOrderCoordinator.sharedInstance.showDangChuyenDialog2DaGiao(id: 0)
                    print("Cancel success")
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                default: break
                }
            }).addDisposableTo(bag)
    }
}
