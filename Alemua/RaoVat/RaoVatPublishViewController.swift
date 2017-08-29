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

class RaoVatPublishViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    
    //Drop down
    let danhMucCha = DropDown()
    let danhMucCon = DropDown()

    
    override func bindToViewModel() {
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
        danhMucCha.dataSource = ["1", "2", "3"]
        danhMucCha.width = 180
        
        danhMucCon.anchorView = stackDanhMucCon
        danhMucCon.dataSource = ["1", "2", "3"]
        danhMucCon.width = 180
        danhMucCha.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfDanhMucCha.text = item
        }
        danhMucCon.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfDanhMucCon.text = item
        }
        
        stackDanhMucCha.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSelectCha)))
        stackDanhMucCon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSelectCon)))


    }
    
    
    func onSelectCha() {
        danhMucCha.show()
    }
    
    func onSelectCon() {
        danhMucCon.show()
    }
    
    override func responseFromViewModel() {
        
    }
    
    
    
    
    @IBAction func onAddPhoto(_ sender: Any) {
        if listImage.count < 5 {
            PictureHelper.pickPhoto(delegate: self, vc: self)
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
        if listImage.count > 0 {
            LoadingOverlay.shared.showOverlay(view: self.view)
            //            upload image
            AlemuaApi.shared.aleApi.request(AleApi.uploadFile(photos: listImage))
                .toJSON()
                .subscribe(onNext: { (res) in
                    switch res {
                    case .done(_, let msg):
                        Toast(text: msg).show()
                        LoadingOverlay.shared.hideOverlayView()
//                        TaoDonHangViewController.sharedInstance.moveToViewController(at: 1)
                        break
                    case .error(let msg):
                        Toast(text: msg).show()
                        break
                    }
                }).addDisposableTo(bag)
        } else {
//            TaoDonHangViewController.sharedInstance.moveToViewController(at: 1)
            
        }
    }
}

