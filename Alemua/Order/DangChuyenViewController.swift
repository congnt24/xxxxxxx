//
//  DangChuyenViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift

class DangChuyenViewController: UIViewController {
    @IBOutlet weak var lbNgay: UILabel!
    @IBOutlet weak var lbGio: UILabel!
    @IBOutlet weak var lbPhut: UILabel!
    @IBOutlet weak var uiReview1: ReviewView!
    @IBOutlet weak var uiReview2: ReviewView!
    @IBOutlet weak var uiItemView: ItemView!
    @IBOutlet weak var tfMuaTu: AwesomeTextField!
    @IBOutlet weak var tfGiaoDen: AwesomeTextField!
    @IBOutlet weak var tfTruocNgay: AwesomeTextField!
    @IBOutlet weak var ifTongGia: AwesomeTextField!
    @IBOutlet weak var tfMoTa: AwesomeTextField!
    @IBOutlet weak var tfGhiChu: AwesomeTextField!
    @IBOutlet weak var uiDelivery: AwesomeToggleViewByHeight!
    @IBOutlet weak var uiOrder: UIStackView!

    @IBOutlet weak var uiRateDetail: RateDetail!
    let bag = DisposeBag()
    var orderData: ModelOrderClientData!
    var modelDangChuyen: ModelDonHangDangChuyenData! {
        didSet {
            bindData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchData
        AlemuaApi.shared.aleApi.request(.getOrderDetails(orderType: 2, orderId: orderData.id!))
        .toJSON().subscribe(onNext: { (res) in
            switch res {
            case .done(let result, _):
                self.modelDangChuyen = ModelDonHangDangChuyenData(json: result)
                break
            case .error(let msg):
                print("ERROR: \(msg)")
                break
            }
        }).addDisposableTo(bag)
        
    }
    
    func bindData(){
        uiItemView.bindData(title: modelDangChuyen.productName!, imageUrl: orderData.photo!, baogia: "\(orderData.quantity!)")
        uiItemView.baogia.alpha = 0
        tfMuaTu.text = modelDangChuyen.buyFrom
        tfGiaoDen.text = modelDangChuyen.deliveryTo
        tfTruocNgay.text = modelDangChuyen.deliveryDate?.toFormatedDate()
        ifTongGia.text = "\(modelDangChuyen.getTotal())".toFormatedPrice()
        tfMoTa.text = modelDangChuyen.descriptionValue
        tfGhiChu.text = modelDangChuyen.note
        //bind rate detail
        if HomeViewController.homeType == .order {
            uiRateDetail.setupRateDetailForMuaHang(RateDetailData(tonggia: modelDangChuyen.totalPrice, giamua: modelDangChuyen.buyingPrice,  discount: modelDangChuyen.discount, magiamgia: modelDangChuyen.promotion_money, thue: modelDangChuyen.tax, phichuyennoidia: modelDangChuyen.transferDomesticFee, phinguoimua: modelDangChuyen.transferBuyerFee, phivanchuyenvealemua: modelDangChuyen.transferAlemuaFree, phivanchuyenvetaynguoimua: modelDangChuyen.transferToBuyerFee, phigiaodichquaalemua: modelDangChuyen.transactionAlemuaFree, weight: modelDangChuyen.weight))
            uiRateDetail.height = 120
        } else {
            uiRateDetail.bindData(RateDetailData(tonggia: modelDangChuyen.totalPrice, giamua: modelDangChuyen.buyingPrice,  discount: modelDangChuyen.discount, magiamgia: modelDangChuyen.promotion_money, thue: modelDangChuyen.tax, phichuyennoidia: modelDangChuyen.transferDomesticFee, phinguoimua: modelDangChuyen.transferBuyerFee, phivanchuyenvealemua: modelDangChuyen.transferAlemuaFree, phivanchuyenvetaynguoimua: modelDangChuyen.transferToBuyerFee, phigiaodichquaalemua: modelDangChuyen.transactionAlemuaFree, weight: modelDangChuyen.weight))
        }
        
        uiReview1.bindData(name: modelDangChuyen.userPostName, rating: modelDangChuyen.userPostRating, nguoidang: 0)
        uiReview2.bindData(name: modelDangChuyen.userShipName, rating: modelDangChuyen.userShipRating, nguoidang: 1)
        
        
        let diffDate = Date().diffDate(toDate: orderData.deliveryDate?.toDate() ?? Date())
        if diffDate.day ?? -1 < 0 || diffDate.hour ?? -1 < 0 || diffDate.minute ?? -1 < 0 {
            lbGio.text = "00"
            lbNgay.text = "00"
            lbPhut.text = "00"
        }else{
            
            if (diffDate.hour ?? 0) < 10 {
                lbGio.text = "0\(diffDate.hour ?? 0)"
            }else{
                lbGio.text = "\(diffDate.hour ?? 0)"
            }
            if (diffDate.day ?? 0) < 10 {
                lbNgay.text = "0\(diffDate.day ?? 0)"
            }else{
                lbNgay.text = "\(diffDate.day ?? 0)"
            }
            if (diffDate.minute ?? 0) < 10 {
                lbPhut.text = "0\(diffDate.minute ?? 0)"
            }else{
                lbPhut.text = "\(diffDate.minute ?? 0)"
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        if HomeViewController.homeType == .order {
            uiOrder.isHidden = false
            uiDelivery.heightConstraint?.constant = 0
        } else {
            uiOrder.isHidden = true
            uiDelivery.heightConstraint?.constant = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onToggleMoreDetails(_ sender: Any) {
//        uiMoreDetails.toggleHeight()
    }

    @IBAction func onBaoXau(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showDangChuyenDialog1BaoXau(modelDangChuyen: modelDangChuyen)
    }

    @IBAction func onDaGiaoHangDelivery(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showDangChuyenDialog2DaGiao(id: 0)
    }
    @IBAction func onDaGiaoHangOrder(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showDangChuyenDialog2DaGiao(id: modelDangChuyen.id)
    }
    @IBAction func onHuyDon(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showDangChuyenDialog3HuyDon(orderId: orderData.id)
    }
    @IBOutlet weak var onToggleRateView: AwesomeToggleButton!
    @IBAction func onToggleRateDetail(_ sender: Any) {
        uiRateDetail.toggleHeight()
    }
}
