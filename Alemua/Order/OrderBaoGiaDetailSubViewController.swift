//
//  OrderBaoGiaDetailSubViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift

class OrderBaoGiaDetailSubViewController: BaseViewController {
    var modelOrderBaoGia: ModelOrderBaoGiaData!
    var orderData: ModelOrderClientData!
    @IBOutlet weak var userView: UserView!
    @IBOutlet weak var uiMoreDetail: AwesomeToggleViewByHeight!
    @IBOutlet weak var danhgia1: DanhGiaView!
    @IBOutlet weak var danhgia2: DanhGiaView!
    @IBOutlet weak var itemView: ItemView!
    
    @IBOutlet weak var tfMuatu: AwesomeTextField!
    @IBOutlet weak var tfGiaoden: AwesomeTextField!
    @IBOutlet weak var tfNgay: AwesomeTextField!
    @IBOutlet weak var tfGia: AwesomeTextField!
    @IBOutlet weak var tfMota: AwesomeTextField!
    @IBOutlet weak var tfLuachon: AwesomeTextField!
    
    let bag = DisposeBag()
    
    var datas = Variable<[CommentData]>([])
    override func bindToViewModel() {
        userView.toggleView = {
            self.uiMoreDetail.toggleHeight()
        }
        bindData()
    }

    @IBAction func onDatMua(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showBaoGiaDetailDialog1(id: modelOrderBaoGia.orderId, quoteId: modelOrderBaoGia.id)
    }
    
    func bindData () {
        itemView.bindData(title: orderData.productName!, imageUrl: orderData.photo!, baogia: "\(orderData.productOption!)")
        tfMuatu.text = modelOrderBaoGia.buyFrom
        tfGiaoden.text = modelOrderBaoGia.deliveryTo
        tfNgay.placeholder = modelOrderBaoGia.deliveryDate?.toFormatedDate()
        tfGia.text = "\(modelOrderBaoGia.totalPrice!)".toFormatedPrice()
        tfMota.text = modelOrderBaoGia.descriptionValue
        userView.bindData(photo: orderData.photo, name: modelOrderBaoGia.userPost, rating: modelOrderBaoGia.rating!, profileType: 2)
        
        
        AlemuaApi.shared.aleApi.request(.getCommentOfShipper(page_number: 1))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result):
//                    let data = CommentData(json: result)
//                    if let data = data {
//                        if data
//                    }
                    
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
