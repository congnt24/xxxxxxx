//
//  TaoDonHang1ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/26/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import AwesomeMVVM
import MobileCoreServices
import RxSwift
import Kingfisher
import Toaster

class TaoDonHang1ViewController: UIViewController, IndicatorInfoProvider, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var tfTenSP: AwesomeTextField!
    @IBOutlet weak var tfMota: AwesomeTextField!
    @IBOutlet weak var tfWebsite: AwesomeTextField!
    @IBOutlet weak var tfGia: AwesomeTextField!
    @IBOutlet weak var tfCode: AwesomeTextField!
    @IBOutlet weak var stSoLuong: StepperView!
    @IBOutlet weak var grSelect: AwesomeRadioGroup!
    @IBOutlet weak var stPhoto: UIStackView!

    @IBOutlet weak var btnAdd: UIButton!
    var website_url: String?
    var data: ModelOrderData?
    
    //from exchange dialog
    var currencyData: CurrencyData? {
        didSet {
            taodonhangRequest.currencyId = currencyData?.id
        }
    }
    var gia: String? {
        didSet {
            if var gia = gia {
//                gia = String(gia.characters.filter { Int("\($0)") != nil })
                let f = Double(gia) ?? 0
                taodonhangRequest.websiteRealPrice = Float(f)
                if let currencyData = currencyData, currencyData.conversion != "1" {
                    let exchange = Float(currencyData.conversion!) ?? 0
                    let vnd = Int(Double(exchange) * f)
                    taodonhangRequest.websitePrice = vnd
                    tfGia.text = "\(f) \(currencyData.name!) - \("\(vnd)".toFormatedPrice())"
                } else {
                    let intgia = Int(Double(gia) ?? 0) ?? 0
                    print(intgia)
                    print(gia)
                    tfGia.text = "\(intgia)".toFormatedPrice()
                    taodonhangRequest.websitePrice = intgia
                }
            }
        }
    }
    

    var taodonhangRequest = TaoDonHangRequest()
    static var sharedInstance: TaoDonHang1ViewController!
    let bag = DisposeBag()
    var listImage = [UIImage]()
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        AwesomeDialog.shared.show(vc: self.parent, name: "Main", identify: "DialogTaoDonHang")
        if let price = taodonhangRequest.websiteRealPrice {
            DialogTaoDonHang.shared.input.text = "\(Double(price) ?? 0)"
        }else{
            let tmp = (tfGia.text ?? "").splitted(by: " ")
            if tmp.count > 0 {
                let gia = String(tmp[0].characters.filter { Int("\($0)") != nil })
                DialogTaoDonHang.shared.input.text = gia
            }else{
                
            }
        }
        return false;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        TaoDonHang1ViewController.sharedInstance = self
        if let url = website_url {
            getDataFromUrl(website_url: url)
        }
        tfGia.delegate = self
        tfWebsite.text = website_url
        tfTenSP.text = data?.name
        //get
        if let p = data?.photo, let url = URL(string: p) {
            KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                if let image = image {
                    self.addPhoto(image: image)
                }
            })
        }
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Thông tin")
    }

    @IBAction func onNext(_ sender: Any) {
        setData()
        if taodonhangRequest.validateStep1() {
            if listImage.count > 0 {
                LoadingOverlay.shared.showOverlay(view: parent?.view)
//            upload image
                AlemuaApi.shared.aleApi.request(AleApi.uploadFile(photos: listImage))
                    .toJSON()
                    .subscribe(onNext: { (res) in
                        switch res {
                        case .done(let result, _):
                            LoadingOverlay.shared.hideOverlayView()
                            self.taodonhangRequest.photo = result.string
                            TaoDonHangViewController.sharedInstance.moveToViewController(at: 1)
                            print("Cancel success")
                            break
                        case .error(let msg):
                            print("Error \(msg)")
                            Toast(text: msg).show()
                            break
                        }
                    }).addDisposableTo(bag)
            } else {
                TaoDonHangViewController.sharedInstance.moveToViewController(at: 1)

            }
        } else {
            Toast(text: "Vui lòng nhập đầy đủ thông tin").show()
        }
    }

    func setData() {
        taodonhangRequest.productName = tfTenSP.text
        taodonhangRequest.productDescription = tfMota.text
        taodonhangRequest.websiteUrl = tfWebsite.text
        taodonhangRequest.promotionCode = tfCode.text
        taodonhangRequest.quantity = stSoLuong.number
        taodonhangRequest.productOption = grSelect.getCheckedPositions().map {"\($0 + 1)"}.joined(separator: ",")
        taodonhangRequest.numberProduct = stSoLuong.number
        print("asd")
        print(grSelect.getCheckedPositions().map {"\($0)"}.joined(separator: ","))
    }
    @IBAction func onAddPhoto(_ sender: Any) {
        if listImage.count < 5 {
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
            addPhoto(image: image)

        }
    }
    
    func addPhoto(image: UIImage){
        listImage.append(image)
        stPhoto.addArrangedSubview(PhotoView(image: image))
        stPhoto.removeArrangedSubview(btnAdd)
        stPhoto.addArrangedSubview(btnAdd)
    }

    //tu dong gan link
    func getDataFromUrl(website_url: String) {
        
        LoadingOverlay.shared.showOverlay(view: parent?.view)
        self.tfGia.text = "\(self.data?.promotionPrice ?? 0)".toFormatedPrice()
        taodonhangRequest.websitePrice = self.data?.promotionPrice ?? 0
        AlemuaApi.shared.aleApi.request(.getDataFromUrl(website_url: website_url))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    LoadingOverlay.shared.hideOverlayView()
                    let title = result["title"].string
                    let desc = result["description"].string
                    self.tfMota.text = desc
                    if let title = title, title != "" {
                        self.tfTenSP.text = title
                    }
                    if let link = result["link"].string {
                        let arr = link.splitted(by: ",")
                        for url in arr {
                            KingfisherManager.shared.retrieveImage(with: URL(string: url)!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                                if let img = image {
                                    self.stPhoto.addArrangedSubview(PhotoView(image: img))
                                    self.listImage.append(img)
                                    self.stPhoto.removeArrangedSubview(self.btnAdd)
                                    self.stPhoto.addArrangedSubview(self.btnAdd)
                                }
                            })
                        }
                    }


                    break
                case .error(let msg):
                    LoadingOverlay.shared.hideOverlayView()
                    Toast(text: msg).show()
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }


    
    
}
