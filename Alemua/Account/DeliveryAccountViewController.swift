//
//  DeliveryAccountViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/28/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class DeliveryAccountViewController: BaseViewController {
    @IBOutlet weak var uiMoreDetails: AwesomeToggleViewByHeight!
    @IBOutlet weak var uiSwitchNotify: UISwitch!
    @IBOutlet weak var uiNotify: UIStackView!
    @IBOutlet weak var uiSetting: UIStackView!
    @IBOutlet weak var uiInviteFriend: UIStackView!
    @IBOutlet weak var uiThongTinThanhToan: UIStackView!
    
    @IBOutlet weak var lbDesc: UILabel!
    @IBOutlet weak var lbDangxuly: UILabel!
    @IBOutlet weak var lbHoanthanh: UILabel!
    @IBOutlet weak var lbDahuy: UILabel!
    @IBOutlet weak var lbThuNhap: UILabel!
    
    @IBOutlet weak var danhsachKH: UIStackView!
    @IBOutlet weak var donhangDunghan: UIStackView!
    @IBOutlet weak var donhangTruochan: UIStackView!
    @IBOutlet weak var donhangGiaocham: UIStackView!
    @IBOutlet weak var donhangBihuy: UIStackView!
    @IBOutlet weak var thunhap: UIStackView!
    
    @IBOutlet weak var userView: UserView!
    @IBOutlet weak var lbNumDSKH: UILabel!
    @IBOutlet weak var lbNumDungHan: UILabel!
    @IBOutlet weak var lbNumTruocHan: UILabel!
    @IBOutlet weak var lbNumCham: UILabel!
    @IBOutlet weak var lbNumHuy: UILabel!
    @IBOutlet weak var lbNumThuNhap: UILabel!
    
    
    var data: ProfileData?
    let bag = DisposeBag()
    override func bindToViewModel() {
        let tapSetting = UITapGestureRecognizer(target: self, action: #selector(self.showAccountSetting(_:)))
        let tapInvite = UITapGestureRecognizer(target: self, action: #selector(self.showAccountInvite(_:)))
        uiSetting.addGestureRecognizer(tapSetting)
        uiInviteFriend.addGestureRecognizer(tapInvite)
        uiNotify.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.toggleNotify(_:))))
        
        uiThongTinThanhToan.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onSHowThanhToan(_:))))
        
        userView.toggleView = {
            self.uiMoreDetails.toggleHeight()
        }
        setupOnclick()
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !Prefs.isUserLogged {
            if LoginViewController.isIgnore {
                LoginViewController.isIgnore = false
                onBack("")
            }else{
                HomeCoordinator.sharedInstance.showLoginScreen()
            }
            return
        }
        if Prefs.isUserLogged {
            AlemuaApi.shared.aleApi.request(.getUserProfile(profileType: 2))
                .toJSON()
                .subscribe(onNext: { (res) in
                    switch res {
                    case .done(let result, _):
                        self.data = ProfileData(json: result)
                        self.userView.bindData(data: self.data!, profileType: 2)
                        self.uiSwitchNotify.isOn = self.data?.isNotify! == 0 ? false : true
                        
                        self.lbDangxuly.text = "\(self.data?.transaction_alemua ?? 0)"
                        self.lbHoanthanh.text = "\(self.data?.transaction_myself ?? 0)"
                        self.lbDahuy.text = "\(self.data?.income ?? 0)".toRaoVatPriceFormat()
                        self.lbDesc.text = "\"\(self.data?.description ?? "")\""
                        
                        
                        self.lbNumDSKH.text = "\(self.data?.numberUser ?? 0)"
                        self.lbNumDungHan.text = "\(self.data?.number_order_in_time ?? 0)"
                        self.lbNumTruocHan.text = "\(self.data?.number_order_in_time ?? 0)"
                        self.lbNumCham.text = "\(self.data?.number_order_slow_time ?? 0)"
                        self.lbNumHuy.text = "\(self.data?.number_order_cancelled ?? 0)"
                        
                        print("Get Profile success")
                        break
                    case .error(let msg):
                        print("Error \(msg)")
                        break
                    }
                }).addDisposableTo(bag)
        }
    }
    
    
    
    func toggleNotify(_ sender: UITapGestureRecognizer) {
        uiSwitchNotify.isOn = !uiSwitchNotify.isOn
    }
    func onSHowThanhToan(_ sender: UITapGestureRecognizer) {
        DeliveryCoordinator.sharedInstance.showThanhToanViewController()
    }
    
    func showAccountSetting(_ sender: UITapGestureRecognizer) {
        AccountCoordinator.sharedInstance.showAccountSetting()
    }
    
    func showAccountInvite(_ sender: UITapGestureRecognizer) {
        AccountCoordinator.sharedInstance.showAccountInvite(code: "12312312")
    }
    override func responseFromViewModel() {
        
    }
    
    @IBAction func onEditAccount(_ sender: Any) {
        //convert to Profile Data
        AccountCoordinator.sharedInstance.openEditAccount(data: data)
    }
    @IBAction func onNotifyChange(_ sender: UISwitch) {
        let req = UpdateProfileRequest()
        req.name = data?.name
        req.address = data?.address
        req.email = data?.email
        req.descriptionValue = data?.description
        req.photo = data?.photo
        req.profileType = 1
        req.isNotify = uiSwitchNotify.isOn ? 1 : 0
        AlemuaApi.shared.aleApi.request(.updateProfile(data: req))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done( _):
                    print("Update profile success")
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    sender.isOn = !sender.isOn
                    break
                }
            }).addDisposableTo(bag)
        
        
    }
    // MARK: - Action
    @IBAction func onBack(_ sender: Any) {
        if HomeViewController.homeType == .order {
            OrderNavTabBarViewController.sharedInstance.switchTab(index: 0)
        } else {
            DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 0)
        }
    }
}



extension DeliveryAccountViewController {
    
    
    func setupOnclick(){
        danhsachKH.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDSKH)))
        donhangDunghan.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDHDaGiao)))
        donhangTruochan.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDHDaGiao)))
        donhangGiaocham.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDH)))
        donhangBihuy.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDHBiHuy)))
        thunhap.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showThuNhap)))
    }
    
    func showDSKH(){
        DeliveryOrderViewController.backToAccount = true
        DeliveryCoordinator.sharedInstance.showDanhSachKH()
    }
    func showDHDaGiao(){
        DeliveryOrderViewController.backToAccount = true
        DeliveryOrderViewController.defaultTab = 2
        DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 1)
    }
    func showDH(){
        DeliveryOrderViewController.backToAccount = true
        DeliveryOrderViewController.defaultTab = 0
        DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 1)
    }
    func showDHBiHuy(){
        DeliveryOrderViewController.backToAccount = true
        DeliveryOrderViewController.defaultTab = 3
        DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 1)
    }
    func showThuNhap(){
//        DeliveryIncomeViewController
        DeliveryCoordinator.sharedInstance.showThuNhap()
    }
    
    
    
    
    
    func fetchData(){
        AlemuaApi.shared.aleApi.request(AleApi.getAllMoney(infor_type: 1))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    print("get all money success")
                    if let arr = result.array {
                        let thunhap = arr.map { $0["total_money"].int ?? 0}.reduce(0, +)
                        print("thunhap \(thunhap)")
                        self.lbNumThuNhap.text = "\(thunhap)".toRaoVatPriceFormat()
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }
    
}
