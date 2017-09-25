//
//  AccountViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//


import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class AccountViewController: BaseViewController {
    @IBOutlet weak var uiMoreDetails: AwesomeToggleViewByHeight!
    @IBOutlet weak var uiSwitchNotify: UISwitch!
    @IBOutlet weak var uiNotify: UIStackView!
    @IBOutlet weak var uiSetting: UIStackView!
    @IBOutlet weak var uiInviteFriend: UIStackView!
    let bag = DisposeBag()

    @IBOutlet weak var userView: UserView!
    @IBOutlet weak var lbDangxuly: UILabel!
    @IBOutlet weak var lbHoanthanh: UILabel!
    @IBOutlet weak var lbDahuy: UILabel!
    @IBOutlet weak var lbDesc: UILabel!

    var data: ProfileData?
    override func bindToViewModel() {
        let tapSetting = UITapGestureRecognizer(target: self, action: #selector(self.showAccountSetting(_:)))
        let tapInvite = UITapGestureRecognizer(target: self, action: #selector(self.showAccountInvite(_:)))
        uiSetting.addGestureRecognizer(tapSetting)
        uiInviteFriend.addGestureRecognizer(tapInvite)
        uiNotify.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.toggleNotify(_:))))

        userView.toggleView = {
            self.uiMoreDetails.toggleHeight()
        }


    }

    override func viewDidAppear(_ animated: Bool) {
        //TODO: Check if user is logged
        if !Prefs.isUserLogged {
            if LoginViewController.isIgnore {
                onBack("")
                LoginViewController.isIgnore = false
            } else {
                HomeCoordinator.sharedInstance.showLoginScreen()
            }
            return
        }

        if Prefs.isUserLogged {
            AlemuaApi.shared.aleApi.request(.getUserProfile(profileType: 1))
                .toJSON()
                .subscribe(onNext: { (res) in
                    switch res {
                    case .done(let result, _):
                        self.data = ProfileData(json: result)
                        self.userView.bindData(data: self.data!, profileType: 1)
                        self.uiSwitchNotify.isOn = self.data?.isNotify! == 0 ? false : true

                        self.lbDangxuly.text = "\(self.data?.transaction_alemua ?? 0)"
                        self.lbHoanthanh.text = "\(self.data?.transaction_myself ?? 0)"
                        self.lbDahuy.text = "\(self.data?.totalMoney ?? 0)".toRaoVatPriceFormat()
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
        AccountCoordinator.sharedInstance.showAccountInvite(code: data!.introduceCode)
    }
    override func responseFromViewModel() {

    }

    @IBAction func onEditAccount(_ sender: Any) {
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
        req.isNotify = sender.isOn ? 1 : 0
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

    @IBAction func onBack(_ sender: Any) {
        if HomeViewController.homeType == .order {
            OrderNavTabBarViewController.sharedInstance.switchTab(index: 0)
        } else {
            DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 0)
        }
    }
}

