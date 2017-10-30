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
import MobileCoreServices
import Kingfisher
import Toaster
import DropDown

class RaoVatPublishViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    var bag = DisposeBag()
    
    @IBOutlet weak var stPhoto: UIStackView!
    @IBOutlet weak var btnAdd: UIButton!
    var listImage = [UIImage]()
    
    @IBOutlet weak var tfTieuDe: AwesomeTextField!
    @IBOutlet weak var tfMota: AwesomeTextField!
    @IBOutlet weak var btnCoSan: CheckedButton!
    @IBOutlet weak var btnDaSuDung: CheckedButton!
    
    @IBOutlet weak var tfDanhMucCha: AwesomeTextField!
    @IBOutlet weak var tfDanhMucCon: AwesomeTextField!
    @IBOutlet weak var stackDanhMucCha: UIStackView!
    @IBOutlet weak var stackDanhMucCon: UIStackView!
    @IBOutlet weak var btnSangTay: CheckedButton!
    @IBOutlet weak var tfGia: AwesomeTextField!
    @IBOutlet weak var tfKhuyenMai: AwesomeTextField!
    @IBOutlet weak var lbGiaKM: UILabel!
    @IBOutlet weak var tfAddress: AwesomeTextField!
    @IBOutlet weak var tfDate: AwesomeTextField!
    var selectedLat = 21.0
    var selectedLon = 105.81
    
    var advRequest = AdvRequest()
    var data: ProductResponse?
    var categoryData = [AdvCategoryResponse]()
    public static var shared: RaoVatPublishViewController!
    
    
    override func viewDidAppear(_ animated: Bool) {
        if !Prefs.isUserLogged {
            if LoginViewController.isIgnore {
                LoginViewController.isIgnore = false
                RaoVatCoordinator.sharedInstance.navigation?.popViewController()
            }else{
                HomeCoordinator.sharedInstance.showLoginScreen()
            }
            return
        }
        if isNotEnoughInfo() {
            print("EditAccountViewController.isIgnore \(EditAccountViewController.isIgnore )")
            if EditAccountViewController.isIgnore {
                EditAccountViewController.isIgnore = false
                navigationController?.popViewController()
            } else {
                AccountCoordinator.sharedInstance.openEditAccount(user_id: Prefs.userId)
            }
            return
        }
    }
    
    func bindRequest(){
        
        advRequest.title = tfTieuDe.text
        advRequest.descriptionValue = tfMota.text
        advRequest.price = Int(tfGia.text?.replacing(".", with: "") ?? "0")
        advRequest.transactionAddress = tfAddress.text
        advRequest.promotion = Int(tfKhuyenMai.text ?? "0")
        advRequest.photo = data?.photo ?? ""
        advRequest.latitude = Float(selectedLat)
        advRequest.longitude = Float(selectedLon)
        advRequest.endDate = tfDate.text?.fromReadableToDate()?.formatDate(format: "yyyy-MM-dd")
        if btnCoSan.isChecked {
            advRequest.productType = 1
        } else if btnSangTay.isChecked {
            advRequest.productType = 2
        } else {
            advRequest.productType = 3
        }
        
    }
    
    
    //Drop down
    let danhMucCha = DropDown()
    let danhMucCon = DropDown()
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        RaoVatCoordinator.sharedInstance.showSelectMapViewController()
        return false;
    }
    
    override func bindToViewModel() {
        tfDate.text = ""
        RaoVatPublishViewController.shared = self
        categoryData = RaoVatViewController.shared.datas.value
        btnCoSan.onChange = {bo in
            self.btnDaSuDung.isChecked = false
            self.btnSangTay.isChecked = false
        }
        btnSangTay.onChange = {bo in
            self.btnCoSan.isChecked = false
            self.btnDaSuDung.isChecked = false
        }
        btnDaSuDung.onChange = {bo in
            self.btnCoSan.isChecked = false
            self.btnSangTay.isChecked = false
        }
        
        
        danhMucCha.anchorView = stackDanhMucCha
        danhMucCha.dataSource = RaoVatViewController.shared.datas.value.map { $0.name! }
        danhMucCha.width = 180
        
        danhMucCon.anchorView = stackDanhMucCon
        danhMucCon.dataSource = [""]
        danhMucCon.width = 180
        danhMucCha.selectionAction = { [unowned self] (index: Int, item: String) in
            self.advRequest.categoryId = RaoVatViewController.shared.datas.value[index].id
            self.tfDanhMucCha.text = item
            self.danhMucCon.dataSource = self.categoryData[self.danhMucCha.indexForSelectedRow!].subCategory!.map { $0.name! }
            self.danhMucCon.selectRow(at: 0)
            self.tfDanhMucCon.text = self.danhMucCon.dataSource[0]
        }
        danhMucCon.selectionAction = { [unowned self] (index: Int, item: String) in
            self.advRequest.subCategoryId = self.categoryData[self.danhMucCha.indexForSelectedRow!].subCategory?[index].id
            self.tfDanhMucCon.text = item
        }
        
        stackDanhMucCha.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSelectCha)))
        stackDanhMucCon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSelectCon)))

        
        tfGia.rx.controlEvent(UIControlEvents.editingDidEnd).subscribe(onNext: {
            self.tfGia.text = ((self.tfGia.text ?? "0").replacing(".", with: "")).toRaoVatPriceFormat()
            self.updateGiaKM()
        }).addDisposableTo(bag)
        tfKhuyenMai.rx.controlEvent(UIControlEvents.editingDidEnd).subscribe(onNext: {
            self.updateGiaKM()
        }).addDisposableTo(bag)
        
        //default dropdown
        
        self.danhMucCha.selectRow(at: 0)
        self.tfDanhMucCha.text = self.danhMucCha.dataSource[0]
        self.danhMucCon.dataSource = self.categoryData[0].subCategory!.map { $0.name! }
        
        self.advRequest.categoryId = RaoVatViewController.shared.datas.value[0].id
        self.danhMucCon.selectRow(at: 0)
        self.tfDanhMucCon.text = self.danhMucCon.dataSource[0]
        self.advRequest.subCategoryId = self.categoryData[0].subCategory?[0].id
        
        //map view for address
//        tfAddress.rx.controlEvent(UIControlEvents.editingDidBegin).subscribe(onNext: {
//            
//        })
            tfAddress.delegate = self
        
        bindDataForEditting()
    }
    
    func updateGiaKM(){
        let gia = Int((tfGia.text ?? "0").replacing(".", with: "")) ?? 0
        let km = Int((tfKhuyenMai.text ?? "0").replacing(".", with: "")) ?? 0
        let giaKm = gia * (100 - km) / 100
        lbGiaKM.text = "\(giaKm)".toRaoVatPriceFormat()
    }
    
    
    func onSelectCha() {
        danhMucCha.show()
    }
    
    func onSelectCon() {
        danhMucCon.show()
    }
    
    override func responseFromViewModel() {
        
    }
    
    func bindDataForEditting() {
        if (data != nil) {
            tfTieuDe.text = data?.title ?? ""
            tfMota.text = data?.descriptionValue ?? ""
            tfGia.text = "\(data?.price ?? 0)"
            tfAddress.text = data?.transactionAddress ?? ""
            tfKhuyenMai.text = "\(data?.promotion ?? 0)"
            //photos
            
            
            tfDate.text = data?.endDate?.splitted(by: " ")[0]
            if data?.productType! == 1 {
                btnCoSan.setState(check: true)
            }else if data?.productType == 2{
                btnSangTay.setState(check: true)
            }else{
                btnDaSuDung.setState(check: true)
            }
            updateGiaKM()
            for index in 0..<categoryData.count {
                if(categoryData[index].id! == data!.categoryId!){
                    self.danhMucCha.selectRow(at: index)
                    self.tfDanhMucCha.text = categoryData[index].name
                    self.advRequest.categoryId = categoryData[index].id
                    self.danhMucCon.dataSource = categoryData[index].subCategory!.map { $0.name! }

                    for j in 0..<categoryData[index].subCategory!.count {
                        if(categoryData[index].subCategory![j].id! == data!.subCategoryId!){
                            self.danhMucCon.selectRow(at: j)
                            self.advRequest.subCategoryId = categoryData[index].subCategory![j].id
                            self.tfDanhMucCon.text = categoryData[index].subCategory![j].name
                            break
                        }
                    }
                    break
                }
            }
            
            
            
            
//                    self.danhMucCha.selectRow(at: categoryData[data!.categoryId!])
            //        self.tfDanhMucCha.text = self.danhMucCha.dataSource[0]
            //        self.danhMucCon.selectRow(at: 0)
            //        self.tfDanhMucCon.text = self.danhMucCon.dataSource[0]
        }
        
        if let p = data?.photo {
            let listPhoto = p.splitted(by: ",")
            for item in listPhoto {
                KingfisherManager.shared.retrieveImage(with: URL(string: item)!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                    self.stPhoto.addArrangedSubview(PhotoView(image: image))
                    self.stPhoto.removeArrangedSubview(self.btnAdd)
                    self.stPhoto.addArrangedSubview(self.btnAdd)
                })
            }
        }
    }
    
    @IBAction func onAddPhoto(_ sender: Any) {
        if listImage.count < 5 {
//            PictureHelper.pickPhoto(delegate: self, vc: self)
            PictureHelper.showDialogChoosePhoto(delegate: self, vc: self)
        } else {
            print("Over 5 images is not allowed")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            listImage.append(image)
            stPhoto.addArrangedSubview(PhotoView(image: image))
            //            self.camera.setImage(image, for: .normal)
            stPhoto.removeArrangedSubview(btnAdd)
            stPhoto.addArrangedSubview(btnAdd)
            
        }
    }
    @IBAction func onPublish(_ sender: Any) {
        bindRequest()
        
        //validation
        if advRequest.title ?? "" == "" || advRequest.price ?? 0 == 0 {
            Toast.init(text: "Vui lòng nhập đầy đủ thông tin").show()
            return
        }
        
        
        if listImage.count > 0 {
            LoadingOverlay.shared.showOverlay(view: self.view)
            //            upload image
            AlemuaApi.shared.aleApi.request(AleApi.uploadFile(photos: listImage))
                .toJSON()
                .subscribe(onNext: { (res) in
                    LoadingOverlay.shared.hideOverlayView()
                    switch res {
                    case .done(let result, let msg):
                        var photos = self.advRequest.photo?.splitted(by: ",") ?? []
                        photos.append(contentsOf: result.string?.splitted(by: ",") ?? [])
                        self.advRequest.photo? = photos.joined(separator: ",")
                        self.postData()
//                        TaoDonHangViewController.sharedInstance.moveToViewController(at: 1)
                        break
                    case .error(let msg):
                        Toast(text: msg).show()
                        break
                    }
                }).addDisposableTo(bag)
        } else {
//            TaoDonHangViewController.sharedInstance.moveToViewController(at: 1)
            postData()
        }
    }
    
    func postData(){
        if (data != nil) {
            advRequest.adv_detail_id = data?.id
            LoadingOverlay.shared.showOverlay(view: self.view)
            RaoVatService.shared.api.request(RaoVatApi.updateAdv(advRequest: advRequest))
                .toJSON()
                .subscribe(onNext: { (res) in
                    LoadingOverlay.shared.hideOverlayView()
                    switch res {
                    case .done(let result, let msg):
                        Toast(text: msg).show()
                        RaoVatCategoryViewController.shared.reload = true
                        RaoVatCategoryViewController.shared.shouldRefresh = true
                        RaoVatCoordinator.sharedInstance.navigation?.popViewController()
                        break
                    case .error(let msg):
                        Toast(text: msg).show()
                        print("Error \(msg)")
                        break
                    }
                }).addDisposableTo(bag)
        }else{
            LoadingOverlay.shared.showOverlay(view: self.view)
            RaoVatService.shared.api.request(RaoVatApi.createAdv(advRequest: advRequest))
                .toJSON()
                .subscribe(onNext: { (res) in
                    LoadingOverlay.shared.hideOverlayView()
                    switch res {
                    case .done(let result, let msg):
                        Toast(text: msg).show()
                        if let _ = RaoVatCategoryViewController.shared {
                            RaoVatCategoryViewController.shared.shouldRefresh = true
                            RaoVatCategoryViewController.shared.reload = true
                        }
                        RaoVatCoordinator.sharedInstance.navigation?.popViewController()
                        break
                    case .error(let msg):
                        Toast(text: msg).show()
                        print("Error \(msg)")
                        break
                    }
                }).addDisposableTo(bag)
        }
    }
}

