//
//  RateDetail.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxCocoa
import RxSwift

struct RateDetailData {
    var tonggia: Int?
    var giamua: Int?
    var discount: Int?
    var magiamgia: Int?
    var thue: Int?
    var phichuyennoidia: Int?
    var phinguoimua: Int?
    var phivanchuyenvealemua: Int?
    var phivanchuyenvetaynguoimua: Int?
    var phigiaodichquaalemua: Int?
    var weight: Float?

}

class RateDetail: AwesomeToggleViewByHeight, UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        onShowTransfer()
        return false;
    }
    func onShowTransfer(){
        
        let dialog = UIStoryboard(name: "DonHang", bundle: nil).instantiateViewController(withIdentifier: "DialogSetWeight") as! DialogSetWeight
        dialog.txtWeight = tfWeight.text ?? ""
        AwesomeDialog.shared.show(vc: viewController(), popupVC: dialog)
    }

    @IBOutlet weak var giamgia: AwesomeTextField!
    @IBOutlet weak var uiStackView: UIStackView!
    @IBOutlet weak var tonggia: AwesomeTextField!
    @IBOutlet weak var thue: AwesomeTextField!
    @IBOutlet weak var phichuyennoidia: AwesomeTextField!
    @IBOutlet weak var phinguoimua: AwesomeTextField!
    @IBOutlet weak var phivanchuyenvealemua: AwesomeTextField!
    @IBOutlet weak var phivanchuyenvetaynguoimua: AwesomeTextField!
    @IBOutlet weak var phigiaodichquaalemua: AwesomeTextField!

    @IBOutlet weak var magiamgia: AwesomeTextField!
    @IBOutlet weak var tfWeight: AwesomeTextField!
    var listView: [AwesomeTextField] = []
    var rateData: RateDetailData!
    let bag = DisposeBag()
    
    var onPriceChange: ((_ total: Int?) -> Void)?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.setupView(nibName: "RateDetail")
        //7 item
        listView = uiStackView.arrangedSubviews.map { ($0 as! AwesomeTextField) }
    }

    public func showGiamGia(){
        giamgia.isHidden = false
    }
    public func enableEditing(){
//        tonggia.isUserInteractionEnabled = true
        thue.isUserInteractionEnabled = true
        phichuyennoidia.isUserInteractionEnabled = true
        phinguoimua.isUserInteractionEnabled = true
        phivanchuyenvealemua.isUserInteractionEnabled = true
//        phivanchuyenvetaynguoimua.isUserInteractionEnabled = true
//        phigiaodichquaalemua.isUserInteractionEnabled = true
        giamgia.isUserInteractionEnabled = true
        tfWeight.isUserInteractionEnabled = true
        tfWeight.delegate = self
        tfWeight.leftView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onShowTransfer)))
        bindData(RateDetailData(tonggia: 0, giamua: 0, discount: 0, magiamgia: 0, thue: 0, phichuyennoidia: 0, phinguoimua: 0, phivanchuyenvealemua: 0, phivanchuyenvetaynguoimua: 0, phigiaodichquaalemua: 0, weight: 0))
        
        
        
        magiamgia.rx.text.subscribe(onNext: { (str) in
            self.rateData.discount = Int(str ?? "0")
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
        }).addDisposableTo(bag)
        
        giamgia.rx.text.subscribe(onNext: { (str) in
            self.rateData.discount = Int(str ?? "0")
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
        }).addDisposableTo(bag)
        
        tonggia.rx.text.subscribe(onNext: { (str) in
            self.rateData.giamua = Int(str ?? "0")
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
        }).addDisposableTo(bag)
        thue.rx.text.subscribe(onNext: { (str) in
            self.rateData.thue = Int(str ?? "0")
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
        }).addDisposableTo(bag)
        phichuyennoidia.rx.text.subscribe(onNext: { (str) in
            self.rateData.phichuyennoidia = Int(str ?? "0")
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
        }).addDisposableTo(bag)
        phinguoimua.rx.text.subscribe(onNext: { (str) in
            self.rateData.phinguoimua = Int(str ?? "0")
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
        }).addDisposableTo(bag)
        phivanchuyenvealemua.rx.text.subscribe(onNext: { (str) in
            self.rateData.phivanchuyenvealemua = Int(str ?? "0")
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
        }).addDisposableTo(bag)
        phivanchuyenvetaynguoimua.rx.text.subscribe(onNext: { (str) in
            self.rateData.phivanchuyenvetaynguoimua = Int(str ?? "0")
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
        }).addDisposableTo(bag)
        phigiaodichquaalemua.rx.text.subscribe(onNext: { (str) in
            self.rateData.phigiaodichquaalemua = Int(str ?? "0")
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
        }).addDisposableTo(bag)
        
        
        
        phigiaodichquaalemua.rx.controlEvent(UIControlEvents.editingDidBegin).subscribe(onNext: {
//            if self.phigiaodichquaalemua.text = 0 {
//                self.phigiaodichquaalemua.text = ""
//            }
        }).addDisposableTo(bag)
    }
    
    public func setDefaultValue(value: Int?) {
        bindData(RateDetailData(tonggia: value, giamua: 0, discount: 0, magiamgia: 0, thue: 0, phichuyennoidia: 0, phinguoimua: 0, phivanchuyenvealemua: 0, phivanchuyenvetaynguoimua: 0, phigiaodichquaalemua: 0, weight: 0))
    }

    public func setValues(values: [String]) {
        for index in 0..<listView.count {
            listView[index].text = values[index]
        }
    }

    func bindData(_ rateData: RateDetailData) {
        self.rateData = rateData
        if thue.isUserInteractionEnabled {
            tonggia.text = "\(rateData.giamua!)"
            thue.text = ""
            phichuyennoidia.text = ""
            phinguoimua.text = ""
            phivanchuyenvealemua.text = ""
            phivanchuyenvetaynguoimua.text = ""
            phigiaodichquaalemua.text = "\(rateData.phigiaodichquaalemua!)"
            magiamgia.text = "\(rateData.magiamgia!)".toFormatedPrice()
            tfWeight.text = ""
        }else{
            tonggia.text = "\(rateData.giamua!)".toFormatedPrice()
            thue.text = "\(rateData.thue!)".toFormatedPrice()
            phichuyennoidia.text = "\(rateData.phichuyennoidia!)".toFormatedPrice()
            phinguoimua.text = "\(rateData.phinguoimua!)".toFormatedPrice()
            phivanchuyenvealemua.text = "\(rateData.phivanchuyenvealemua!)".toFormatedPrice()
            phivanchuyenvetaynguoimua.text = "\(rateData.phivanchuyenvetaynguoimua!)".toFormatedPrice()
            phigiaodichquaalemua.text = "\(rateData.phigiaodichquaalemua!)".toFormatedPrice()
            magiamgia.text = "\(rateData.magiamgia!)".toFormatedPrice()
            tfWeight.text = "\(rateData.weight!)"
        }
    }
    
    func bindData(order: ModelOrderBaoGiaData) {
        tonggia.text = "\(order.buyingPrice!)".toFormatedPrice()
        thue.text = "\(order.tax!)".toFormatedPrice()
        phichuyennoidia.text = "\(order.transferDomesticFee!)".toFormatedPrice()
        phinguoimua.text = "\(order.transferBuyerFee!)".toFormatedPrice()
        phivanchuyenvealemua.text = "\(order.transferAlemuaFree!)".toFormatedPrice()
        phivanchuyenvetaynguoimua.text = "\(order.transferToBuyerFee!)".toFormatedPrice()
        phigiaodichquaalemua.text = "\(order.buyingPrice!)".toFormatedPrice()
        magiamgia.text = "\(order.promotion_money!)".toFormatedPrice()
        tfWeight.text = "\(order.weight!)"
    }

    func calculateTotal() -> Int? {
        var arr = [Int]()
        let dis = Float(rateData.discount ?? 0) / Float(100)
        let tong = Float(rateData.tonggia ?? 0)
        let discount = dis * tong
        arr.append(Int(tong - discount))
        arr.append(rateData.thue ?? 0)
        arr.append(rateData.phichuyennoidia ?? 0)
        arr.append(rateData.phigiaodichquaalemua ?? 0)
        arr.append(rateData.phinguoimua ?? 0)
        arr.append(rateData.phivanchuyenvealemua ?? 0)
        arr.append(rateData.phivanchuyenvetaynguoimua ?? 0)
        var sum = 0
        for item in arr {
            sum += item
        }
//        sum -= rateData.discount ?? 0
        return sum

    }
    
    func onUpdateWeight(weight: String?){
        tfWeight.text = weight
        if let weight = weight {
            self.rateData.weight = Float(weight)
            let vc = viewController() as! DeliveryBaoGiaFinalViewController
            AlemuaApi.shared.aleApi.request(AleApi.getTransferMoney(order_id: vc.modelQuoteData.id, weight: Float(weight)))
                .toJSON()
                .subscribe(onNext: { (res) in
                    switch res {
                    case .done( let result, _):
                        let money = result["money"].int
                        self.phivanchuyenvetaynguoimua.text = "\(money ?? 0)"
                        self.rateData.phivanchuyenvetaynguoimua = money ?? 0
                        break
                    case .error(let msg):
                        print("Error \(msg)")
                        break
                    }
                }).addDisposableTo(bag)

        }
    }

}
