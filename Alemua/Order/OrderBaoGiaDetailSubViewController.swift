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
    @IBOutlet weak var itemView: ItemView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tfMuatu: AwesomeTextField!
    @IBOutlet weak var tfGiaoden: AwesomeTextField!
    @IBOutlet weak var tfNgay: AwesomeTextField!
    @IBOutlet weak var tfGia: AwesomeTextField!
    @IBOutlet weak var tfMota: AwesomeTextField!
    @IBOutlet weak var tfLuachon: AwesomeTextField!
    
    let bag = DisposeBag()
    
    var datas = Variable<[CommentData]>([])
    var first = true
    override func bindToViewModel() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        userView.toggleView = {
            self.uiMoreDetail.toggleHeight()
            if self.first {
            self.listComment.asObservable()
                .bind(to: self.tableView.rx.items(cellIdentifier: "DanhGiaTableViewCell")){ (row, item, cell) in
                    (cell as! DanhGiaTableViewCell).bindData(commentData: item)
                }.addDisposableTo(self.bag)
                self.first = false
            }
        }
        bindData()
    }
    

    @IBAction func onDatMua(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showBaoGiaDetailDialog1(id: modelOrderBaoGia.orderId, quoteId: modelOrderBaoGia.id)
    }
    
    var listComment = Variable<[CommentData]>([])
    
    func bindData () {
        itemView.bindData(title: orderData.productName!, imageUrl: orderData.photo!, baogia: "\(orderData.quotes!.count)")
        tfMuatu.text = modelOrderBaoGia.buyFrom
        tfGiaoden.text = modelOrderBaoGia.deliveryTo
        tfNgay.labelLeft = modelOrderBaoGia.deliveryDate!.toFormatedDate()
        tfGia.text = "\(modelOrderBaoGia.totalPrice!)".toFormatedPrice()
        tfMota.text = modelOrderBaoGia.descriptionValue
        userView.bindData(photo: modelOrderBaoGia.userPhoto, name: modelOrderBaoGia.userPost, rating: modelOrderBaoGia.rating!, profileType: 2)
        let headerNib = UINib(nibName: "DanhGiaTableViewCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: "DanhGiaTableViewCell")
        
        AlemuaApi.shared.aleApi.request(.getCommentOfShipper(shipperId: modelOrderBaoGia.userPostId!,page_number: 1))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result):
                    if let arrayComment = result.array {
                        self.listComment.value = arrayComment.map{ CommentData(json: $0)}
                    }
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
