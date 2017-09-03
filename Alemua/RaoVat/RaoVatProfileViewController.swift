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

class RaoVatProfileViewController: BaseViewController {
    var bag = DisposeBag()
    
    var profileData: ProfileData? {
        didSet {
            if let data = profileData {
                userView.bindData(name: data.name, address: data.address, photo: data.photo)
            }
        }
    }
    
    @IBOutlet weak var userView: RaoVatUserView!
    @IBOutlet weak var stFavorite: UIStackView!
    @IBOutlet weak var stPublished: UIStackView!
    override func bindToViewModel() {
        stFavorite.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFavorite)))
        stPublished.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPublished)))
        fetchProfile()
    }
    
    override func responseFromViewModel() {
        
    }
    
    func fetchProfile() {
        AlemuaApi.shared.aleApi.request(AleApi.getUserProfile(profileType: 1))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    self.profileData = ProfileData(json: result)
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                default: break
                }
            }).addDisposableTo(bag)
    }
    
    func onFavorite() {
        RaoVatCoordinator.sharedInstance.showRaoVatListAction(data: .Favorite)
    }
    
    func onPublished() {
        RaoVatCoordinator.sharedInstance.showRaoVatListAction(data: .Published)
    }
    @IBAction func onLogout(_ sender: Any) {
        AlemuaApi.shared.aleApi.request(.logout())
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(_):
                    self.navigationController?.popToRootViewController(animated: true)
                    print("Logout success")
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
        Prefs.isUserLogged = false
        Prefs.userId = 0
        Prefs.apiToken = ""
    }
    @IBAction func onEdit(_ sender: Any) {
    }
}

