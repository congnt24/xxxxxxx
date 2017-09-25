//
//  EditAccountViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa
import MobileCoreServices

class EditAccountViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public static var isIgnore = false
    
    @IBOutlet weak var uiMoreDetails: AwesomeToggleViewByHeight!

    @IBOutlet weak var tfTen: AwesomeTextField!
    @IBOutlet weak var tfDiachi: AwesomeTextField!
    @IBOutlet weak var tfEmail: AwesomeTextField!
    @IBOutlet weak var userView: UserView!
    var coordinator: AccountCoordinator!
    
    @IBOutlet weak var heighPhone: NSLayoutConstraint!
    @IBOutlet weak var stPhone: UIStackView!
    @IBOutlet weak var tfPhone: AwesomeTextField!
    @IBOutlet weak var tvGioiThieu: UITextView!
    @IBOutlet weak var lbDangxuly: UILabel!
    @IBOutlet weak var lbDahuy: UILabel!
    @IBOutlet weak var lbHoanthanh: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    var data: ProfileData?
    var user_id: Int?
    
    
    var data2: ProfileData? {
        didSet {
            if let data = data2 {
                tfTen.text = data.name
                tfDiachi.text = data.address ?? ""
                tfEmail.text = data.email ?? ""
                tvGioiThieu.text = data.description ?? ""
                let phone = data.phoneNumber ?? ""
                tfPhone.text = phone
                if phone != "" {
//                    heighPhone.constant = 0
//                    stPhone.isHidden = true
                    tfPhone.isEnabled = false
                    tfPhone.textColor = UIColor.darkGray
                }
                
                if HomeViewController.homeType == .order {
                    self.userView.bindData(data: data, profileType: 1)
                    self.lbDangxuly.text = "\(data.numberInProgress ?? 0)"
                    self.lbHoanthanh.text = "\(data.numberDone ?? 0)"
                    self.lbDahuy.text = "\(data.numberCancelled ?? 0)"
                }else{
                    self.userView.bindData(data: data, profileType: 2)
                    self.lbDangxuly.text = "\(data.numberOrder ?? 0)"
                    self.lbHoanthanh.text = "\(data.numberUser ?? 0)"
                    self.lbDahuy.text = "\(data.totalMoney ?? 0)"
                }
                
                self.lbDesc.text = "\"\(data.description ?? "")\""
                
            }
        }
    }
    
    let bag = DisposeBag()
    
    override func bindToViewModel() {
        userView.toggleView = {
            self.uiMoreDetails.toggleHeight()
        }
        if let user_id = user_id {
            fetchData(user_id)
        }else{
            data2 = data
        }
        userView.onAvatar = { imgView in
//            PictureHelper.pickPhoto(delegate: self, vc: self)
            
            PictureHelper.showDialogChoosePhoto(delegate: self, vc: self)
        }
    }
    
    override func responseFromViewModel() {

    }
    @IBAction func onDone(_ sender: Any) {
        //update profile
        
        let req = UpdateProfileRequest()
        req.name = tfTen.text
        req.address = tfDiachi.text
        req.email = tfEmail.text
        req.descriptionValue = tvGioiThieu.text
        req.photo = data?.photo
        req.profileType = 2
        req.isNotify = data?.isNotify
        if tfPhone.text != "" {
            req.phoneNumber = tfPhone.text
        }
        
        LoadingOverlay.shared.showOverlay(view: view)
        //            upload image
        
        AlemuaApi.shared.aleApi.request(AleApi.uploadFile(photos: [userView.avatar.image!]))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    LoadingOverlay.shared.hideOverlayView()
                    req.photo = result.string
                    Prefs.photo = result.string ?? ""
                    self.postToServer(req)
                    print("Cancel success")
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
        
        
    }
    func postToServer(_ req: UpdateProfileRequest){
        AlemuaApi.shared.aleApi.request(.updateProfile(data: req))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done( _):
                    AppCoordinator.sharedInstance.navigation?.popViewController()
                    Prefs.userName = req.name ?? ""
                    Prefs.address = req.address ?? ""
                    Prefs.email = req.email ?? ""
                    Prefs.desc = req.descriptionValue ?? ""
                    Prefs.phoneNumber = req.phoneNumber ?? ""
                    print("Update profile success")
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                default: break
                }
            }).addDisposableTo(bag)
    }
    
    func fetchData(_ user_id: Int){
        AlemuaApi.shared.aleApi.request(.getUserProfile(profileType: 1))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    self.data2 = ProfileData(json: result)
                    print("Get Profile success")
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            userView.avatar.image = image
            
        }
    }
    @IBAction func onCancel(_ sender: Any) {
        EditAccountViewController.isIgnore = true
        navigationController?.popViewController()
        
    }
}

