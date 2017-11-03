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
    func onShowTransfer() {

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
        listView = uiStackView.arrangedSubviews.map { ($0.subviews[0] as! AwesomeTextField) }
        giamgia.superview?.isHidden = true
    }

    public func showGiamGia() {
        giamgia.superview?.isHidden = false
    }
    public func enableEditing() {
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
            self.rateData.discount = (str ?? "0").toNumber()
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
            self.magiamgia.text = "\(self.rateData.discount!)".toRaoVatPriceFormat()
        }).addDisposableTo(bag)

        giamgia.rx.text.subscribe(onNext: { (str) in
            self.rateData.discount = (str ?? "0").toNumber()
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
            self.giamgia.text = "\(self.rateData.discount!)".toRaoVatPriceFormat()
        }).addDisposableTo(bag)

        tonggia.isUserInteractionEnabled = true
        tonggia.rx.text.subscribe(onNext: { (str) in
            self.rateData.giamua = (str ?? "0").toNumber()
            print(self.rateData.giamua)
            print("\(self.rateData.giamua!)".toRaoVatPriceFormat())
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
            self.tonggia.text = "\(self.rateData.giamua!)".toRaoVatPriceFormat()
        }).addDisposableTo(bag)
        thue.rx.text.subscribe(onNext: { (str) in
            self.rateData.thue = (str ?? "0").toNumber()
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
            print("\(self.rateData.thue!)".toRaoVatPriceFormat())
            self.thue.text = "\(self.rateData.thue!)".toRaoVatPriceFormat()
        }).addDisposableTo(bag)
        phichuyennoidia.rx.text.subscribe(onNext: { (str) in
            self.rateData.phichuyennoidia = (str ?? "0").toNumber()
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
            self.phichuyennoidia.text = "\(self.rateData.phichuyennoidia!)".toRaoVatPriceFormat()
        }).addDisposableTo(bag)
        phinguoimua.rx.text.subscribe(onNext: { (str) in
            self.rateData.phinguoimua = (str ?? "0").toNumber()
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
            self.phinguoimua.text = "\(self.rateData.phinguoimua!)".toRaoVatPriceFormat()
        }).addDisposableTo(bag)
        phivanchuyenvealemua.rx.text.subscribe(onNext: { (str) in
            self.rateData.phivanchuyenvealemua = (str ?? "0").toNumber()
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
            self.phivanchuyenvealemua.text = "\(self.rateData.phivanchuyenvealemua!)".toRaoVatPriceFormat()
        }).addDisposableTo(bag)
        phivanchuyenvetaynguoimua.rx.text.subscribe(onNext: { (str) in
            self.rateData.phivanchuyenvetaynguoimua = (str ?? "0").toNumber()
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
            self.phivanchuyenvetaynguoimua.text = "\(self.rateData.phivanchuyenvetaynguoimua!)".toRaoVatPriceFormat()
        }).addDisposableTo(bag)
        phigiaodichquaalemua.rx.text.subscribe(onNext: { (str) in
            self.rateData.phigiaodichquaalemua = (str ?? "0").toNumber()
            if let onPriceChange = self.onPriceChange {
                onPriceChange(self.calculateTotal())
            }
            self.phigiaodichquaalemua.text = "\(self.rateData.phigiaodichquaalemua!)".toRaoVatPriceFormat()
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
            tonggia.text = "\(rateData.giamua!)".toFormatedPrice()
            thue.text = ""
            phichuyennoidia.text = ""
            phinguoimua.text = ""
            phivanchuyenvealemua.text = ""
            phivanchuyenvetaynguoimua.text = ""
            phigiaodichquaalemua.text = "\(rateData.phigiaodichquaalemua!)"//.toFormatedPrice()
            magiamgia.text = "\(rateData.magiamgia!)".toFormatedPrice()
            tfWeight.text = ""
        } else {
            tonggia.text = "\(rateData.giamua!)".toFormatedPrice()
            thue.text = "\(rateData.thue!)".toFormatedPrice()
            phichuyennoidia.text = "\(rateData.phichuyennoidia!)".toFormatedPrice()
            phinguoimua.text = "\(rateData.phinguoimua!)".toFormatedPrice()
            phivanchuyenvealemua.text = "\(rateData.phivanchuyenvealemua!)".toFormatedPrice()
            phivanchuyenvetaynguoimua.text = "\(rateData.phivanchuyenvetaynguoimua!)".toFormatedPrice()
            phigiaodichquaalemua.text = "\(rateData.phigiaodichquaalemua!)"//.toFormatedPrice()
            magiamgia.text = "\(rateData.magiamgia!)".toFormatedPrice()
            tfWeight.text = "\(rateData.weight!)"
            giamgia.text = "\(rateData.discount ?? 0)"
        }
    }

    func bindData(order: ModelOrderBaoGiaData) {
        tonggia.text = "\(order.buyingPrice!)".toFormatedPrice()
        thue.text = "\(order.tax!)".toFormatedPrice()
        phichuyennoidia.text = "\(order.transferDomesticFee!)".toFormatedPrice()
        phinguoimua.text = "\(order.transferBuyerFee!)".toFormatedPrice()
        phivanchuyenvealemua.text = "\(order.transferAlemuaFree!)".toFormatedPrice()
        phivanchuyenvetaynguoimua.text = "\(order.transferToBuyerFee!)".toFormatedPrice()
        phigiaodichquaalemua.text = "\(order.buyingPrice!)"//.toFormatedPrice()
        magiamgia.text = "\(order.promotion_money!)".toFormatedPrice()
        tfWeight.text = "\(order.weight!)"
        giamgia.text = "\(order.discount ?? 0)"
    }

    func calculateTotal() -> Int? {
        var arr = [Int]()
        let dis = Float(rateData.discount ?? 0) / Float(100)
        let tong = Float(rateData.tonggia ?? 0)
        let discount = dis * tong
        arr.append(Int(rateData.giamua ?? 0) - Int(discount))
//        arr.append(Int(tong - discount))
        arr.append(rateData.thue ?? 0)
        arr.append(rateData.phichuyennoidia ?? 0)
        let xx = (rateData.phigiaodichquaalemua!) * Int(tong) / 100
        arr.append(xx)
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

    var notUpdateWeight = false
    func onUpdateWeight(weight: String?) {
        tfWeight.text = weight
        if var weight = weight {
            weight = weight.replacing(",", with: ".")
            tfWeight.text = weight
            self.rateData.weight = Float(weight)
            print(self.rateData.weight)
            let vc = viewController() as! DeliveryBaoGiaFinalViewController

            if notUpdateWeight {

            } else {
                AlemuaApi.shared.aleApi.request(AleApi.getTransferMoney(order_id: vc.modelQuoteData.id, weight: Float(weight)))
                    .toJSON()
                    .subscribe(onNext: { (res) in
                        switch res {
                        case .done( let result, _):
                            let money = result["money"].int
                            self.phivanchuyenvetaynguoimua.text = "\(money ?? 0)".toRaoVatPriceFormat()
                            self.rateData.phivanchuyenvetaynguoimua = money ?? 0
                            if let onPriceChange = self.onPriceChange {
                                onPriceChange(self.calculateTotal())
                            }
                            break
                        case .error(let msg):
                            print("Error \(msg)")
                            break
                        }
                    }).addDisposableTo(bag)
            }
        }
    }
    
    func hideForTransactionOption(){
        height = height - 70
        phivanchuyenvealemua.superview?.isHidden = true
        phigiaodichquaalemua.superview?.isHidden = true
    }



    func setupRateDetailForMuaHang(_ rateData: RateDetailData) {
        giamgia.superview?.isHidden = true
        thue.superview?.isHidden = true
        phichuyennoidia.superview?.isHidden = true
        phinguoimua.superview?.isHidden = true
        phivanchuyenvealemua.superview?.isHidden = true
        phigiaodichquaalemua.superview?.isHidden = true

        let xx = rateData.phigiaodichquaalemua! * rateData.giamua! / 100
        tonggia.text = "\(rateData.giamua! + rateData.thue! + rateData.phinguoimua! + xx)".toFormatedPrice()
        print("tonggia.text")
        print(tonggia.text)
        print(rateData.giamua! + rateData.thue! + rateData.phinguoimua! + xx)
        phivanchuyenvetaynguoimua.text = "\(rateData.phivanchuyenvetaynguoimua! + rateData.phivanchuyenvealemua! + rateData.phichuyennoidia!)".toFormatedPrice()
        tfWeight.text = "\(rateData.weight!)"
        magiamgia.text = "\(rateData.magiamgia!)".toFormatedPrice()

    }

}
