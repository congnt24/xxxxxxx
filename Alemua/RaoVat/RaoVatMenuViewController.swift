//
//  BaoGiaViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class RaoVatMenuViewController: BaseViewController {
    var bag = DisposeBag()
    
    @IBOutlet weak var uiSwitch: AwesomeSwitch!
    override func bindToViewModel() {
        LoadingOverlay.shared.showOverlay(view: view)
        AlemuaApi.shared.aleApi.request(AleApi.getUserProfile(profileType: 1))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    let profileData = ProfileData(json: result)
                    self.uiSwitch.isOn = profileData.isNotify == 1 ? true : false
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }, onDisposed: {
                LoadingOverlay.shared.hideOverlayView()
            }).addDisposableTo(bag)
    }
    
    override func responseFromViewModel() {
        
    }
    @IBAction func onTrangChu(_ sender: Any) {
        RaoVatCoordinator.sharedInstance.navigation?.popToRootViewController(animated: true)
    }
    @IBAction func onProfile(_ sender: Any) {
        RaoVatCoordinator.sharedInstance.showRaoVatProfile(data: "")
    }
    @IBAction func onFavorite(_ sender: Any) {
        RaoVatCoordinator.sharedInstance.showRaoVatListAction(data: .Favorite)
    }
    @IBAction func onPublished(_ sender: Any) {
        RaoVatCoordinator.sharedInstance.showRaoVatListAction(data: .Published)
    }
    @IBAction func onNotify(_ sender: Any) {
        uiSwitch.isOn = !uiSwitch.isOn
        let req = UpdateProfileRequest()
        req.profileType = 1
        req.isNotify = uiSwitch.isOn ? 1 : 0
        LoadingOverlay.shared.showOverlay(view: view)
        AlemuaApi.shared.aleApi.request(.updateProfile(data: req))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done( _):
                    print("Update profile success")
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }, onDisposed: {
                LoadingOverlay.shared.hideOverlayView()
            }).addDisposableTo(bag)
        
    }
    @IBAction func onSwitchNotify(_ sender: Any) {
    }
}

