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
    
    @IBOutlet weak var lbDesc: UILabel!
    @IBOutlet weak var lbDangxuly: UILabel!
    @IBOutlet weak var lbHoanthanh: UILabel!
    @IBOutlet weak var lbDahuy: UILabel!
    
    @IBOutlet weak var danhsachKH: UIStackView!
    @IBOutlet weak var donhangDunghan: UIStackView!
    @IBOutlet weak var donhangTruochan: UIStackView!
    @IBOutlet weak var donhangGiaocham: UIStackView!
    @IBOutlet weak var donhangBihuy: UIStackView!
    
    @IBOutlet weak var userView: UserView!
    
    
    var data: ProfileData?
    let bag = DisposeBag()
    override func bindToViewModel() {
        let tapSetting = UITapGestureRecognizer(target: self, action: #selector(self.showAccountSetting(_:)))
        let tapInvite = UITapGestureRecognizer(target: self, action: #selector(self.showAccountInvite(_:)))
        uiSetting.addGestureRecognizer(tapSetting)
        uiInviteFriend.addGestureRecognizer(tapInvite)
        uiNotify.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.toggleNotify(_:))))
        
        userView.toggleView = {
            self.uiMoreDetails.toggleHeight()
        }
        setupOnclick()
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
                        self.userView.bindData(data: self.data!, profileType: 1)
                        self.uiSwitchNotify.isOn = self.data?.isNotify! == 0 ? false : true
                        
                        self.lbDangxuly.text = "\(self.data?.numberOrder ?? 0)"
                        self.lbHoanthanh.text = "\(self.data?.numberUser ?? 0)"
                        self.lbDahuy.text = "\(self.data?.totalMoney ?? 0)"
                        self.lbDesc.text = "\"\(self.data?.description ?? "")\""
                        
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
    }
    
    func showDSKH(){
        DeliveryCoordinator.sharedInstance.showDanhSachKH()
    }
    func showDHDaGiao(){
        DeliveryOrderViewController.defaultTab = 2
        DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 1)
    }
    func showDH(){
        DeliveryOrderViewController.defaultTab = 0
        DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 1)
    }
    func showDHBiHuy(){
        DeliveryOrderViewController.defaultTab = 3
        DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 1)
    }
    
    
    
    
    
    
    
    
}
