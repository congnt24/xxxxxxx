//
//  ThanhToanViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import DropDown
import RxSwift
import Toaster

class ThanhToanViewController: BaseViewController {
    @IBOutlet weak var tfTenTaiKhoan: AwesomeTextField!
    @IBOutlet weak var tfSoTaiKhoan: AwesomeTextField!
    @IBOutlet weak var tfNganHang: AwesomeTextField!
    @IBOutlet weak var tfChiNhanh: AwesomeTextField!
    @IBOutlet weak var tfSoDienThoai: AwesomeTextField!
    @IBOutlet weak var tfDiaChi: AwesomeTextField!
    @IBOutlet weak var tfCMND: AwesomeTextField!
    @IBOutlet weak var tfGhiChu: AwesomeTextField!
    @IBOutlet weak var grSelect: AwesomeRadioGroup!
    @IBOutlet weak var stackNganHang: UIStackView!
    @IBOutlet weak var stackChiNhanh: UIStackView!
    let nganHangDrop = DropDown()
    let chiNhanhDrop = DropDown()
    var bag = DisposeBag()
    override func bindToViewModel() {
        //create Dropdown
        nganHangDrop.anchorView = stackNganHang
        nganHangDrop.dataSource = ["1", "2", "3"]
        nganHangDrop.width = 180

        chiNhanhDrop.anchorView = stackChiNhanh
        chiNhanhDrop.dataSource = ["1", "2", "3"]
        chiNhanhDrop.width = 180
        nganHangDrop.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfNganHang.text = item
        }
        chiNhanhDrop.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfChiNhanh.text = item
        }


        //stackNganHang.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSelectNganHang)))
        //stackChiNhanh.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSelectChiNhanh)))

    }

    @IBAction func onXacNhan(_ sender: Any) {
        LoadingOverlay.shared.showOverlay(view: view)
        let request = UpdateBankAccountRequest()
        request.account_name = tfTenTaiKhoan.text
        request.account_number = tfSoTaiKhoan.text
        request.bank_name = tfNganHang.text
        request.bank_brand = tfChiNhanh.text
        request.phone_number = tfSoDienThoai.text
        request.id_number = tfCMND.text
        request.address = tfDiaChi.text
        request.confirm_type = (grSelect.checkedPosition + 1)
        request.note = tfGhiChu.text
        AlemuaApi.shared.aleApi.request(AleApi.updateBankAccount(req: request))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(_, let msg):
                    Toast.init(text: msg).show()
                    self.navigationController?.popViewController()
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    Toast.init(text: msg).show()
                    break
                }
            }, onDisposed: {
                LoadingOverlay.shared.hideOverlayView()
            }).addDisposableTo(bag)
    }

    func onSelectNganHang() {
        nganHangDrop.show()
    }

    func onSelectChiNhanh() {
        chiNhanhDrop.show()
    }

    func combineInput() -> ThanhToanModel {
        let tt = ThanhToanModel(tentaikhoan: tfTenTaiKhoan.text
            , sotaikhoan: tfSoTaiKhoan.text
            , tennganhang: tfNganHang.text, tenchinhanh: tfChiNhanh.text, sodienthoai: tfSoDienThoai.text, diachi: tfDiaChi.text, cmnd: tfCMND.text
            , selection: grSelect.checkedPosition)

        return tt
    }
}
