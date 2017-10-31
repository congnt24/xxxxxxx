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
import DropDown

class TaoDonHang1ViewController: UIViewController, IndicatorInfoProvider, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var tfTenSP: AwesomeTextField!
    @IBOutlet weak var tfMota: AwesomeTextField!
    @IBOutlet weak var tfWebsite: AwesomeTextField!
    @IBOutlet weak var tfGia: AwesomeTextField!
    @IBOutlet weak var tfCode: AwesomeTextField!
    @IBOutlet weak var stSoLuong: StepperView!
    @IBOutlet weak var grSelect: AwesomeRadioGroup!
    @IBOutlet weak var stPhoto: UIStackView!
    @IBOutlet weak var drNhomHang: UIStackView!
    @IBOutlet weak var drQuocGia: UIStackView!

    @IBOutlet weak var tfQuocGia: AwesomeTextField!
    @IBOutlet weak var tfNhomHang: AwesomeTextField!
    @IBOutlet weak var btnAdd: UIButton!
    var website_url: String?
    var data: ModelOrderData?
    
    var listBranch = [Int]()
    var listCountry = [Int]()
    var branch = -1
    var country = -1
    
    //from exchange dialog
    var currencyData: CurrencyData? {
        didSet {
            taodonhangRequest.currencyId = currencyData?.id
        }
    }
    var gia: String? {
        didSet {
            if let gia = gia {
//                gia = String(gia.characters.filter { Int("\($0)") != nil })
                let f = (Double(gia) ?? 0) * Double(stSoLuong.number)
                taodonhangRequest.websiteRealPrice = Float(f)
                if let currencyData = currencyData, currencyData.conversion != "1" {
                    let exchange = Float(currencyData.conversion!) ?? 0
                    let vnd = Int(Double(exchange) * f)
                    taodonhangRequest.websitePrice = vnd
                    tfGia.text = "\(f) \(currencyData.name!) - \("\(vnd)".toFormatedPrice())"
                } else {
                    let intgia = Int(Double(gia) ?? 0) * stSoLuong.number
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
    
    
    // MARK: - Setup dropdown
    let nhomHangDr = DropDown()
    let quocGiaDr = DropDown()
    
    override func viewDidLoad() {
        grSelect.onValueChange = {pos in
            var listChecked = self.grSelect.getCheckedPositions();
            if (listChecked.contains(0) || listChecked.contains(3)) {
                //disable 2,3
                listChecked = listChecked.filter({ (item) -> Bool in
                    return item != 1 && item != 2
                })
                if (pos != 0 && pos != 3) {
                    listChecked = [pos]
                }
            }
            if (listChecked.contains(1) || listChecked.contains(2)) {
                listChecked = listChecked.filter({ (item) -> Bool in
                    return item != 0 && item != 3
                })
            }
            self.grSelect.multiCheck(poss: listChecked)
            print("Asdasdasd as dsa das   \(pos)")
        }
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
        nhomHangDr.anchorView = drNhomHang
        nhomHangDr.dataSource = ["Tất cả"]
//        nhomHangDr.width = 180
        nhomHangDr.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfNhomHang.text = item
            self.branch = self.listBranch[index]
        }
        
        quocGiaDr.anchorView = drQuocGia
        quocGiaDr.dataSource = ["Hàng mới 100%", "Hàng sang tay", "Đã qua sử dụng"]
//        quocGiaDr.width = 180
        quocGiaDr.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfQuocGia.text = item
            self.country = self.listCountry[index]
        }
        
        
        drNhomHang.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDrNhomHang)))
        drQuocGia.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDrQuocGia)))
        
        
        stSoLuong.onChange = {number in
            print(number)
            self.gia = { self.gia }()
        }
    }
    
    func onDrNhomHang(){
        nhomHangDr.show()
    }
    func onDrQuocGia(){
        quocGiaDr.show()
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Thông tin")
    }

    @IBAction func onNext(_ sender: Any) {
        let na = Array(stPhoto.arrangedSubviews[0..<(stPhoto.arrangedSubviews.count - 1)])
        listImage = na.map { ($0 as! PhotoView).image! }
        setData()
        if taodonhangRequest.validateStep1() {
            
            if taodonhangRequest.productOption == "" {
                Toast.init(text: "Vui lòng lựa chọn sản phẩm").show()
                return
            }
            if branch < 0 || country < 0 {
                Toast(text: "Vui lòng nhập đầy đủ thông tin").show()
                return
            }
            
            
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
        taodonhangRequest.brand_id = branch
        taodonhangRequest.country_id = country
        taodonhangRequest.productName = tfTenSP.text
        taodonhangRequest.productDescription = tfMota.text
        taodonhangRequest.websiteUrl = tfWebsite.text
        taodonhangRequest.promotionCode = tfCode.text
        taodonhangRequest.quantity = stSoLuong.number
        taodonhangRequest.productOption = grSelect.getCheckedPositions().map {"\($0 + 1)"}.joined(separator: ",")
        taodonhangRequest.numberProduct = stSoLuong.number
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
                if let proPrice = data?.promotionPrice {
            if proPrice > 0 {
                self.gia = "\(proPrice)"
//                self.tfGia.text = "\(proPrice)".toFormatedPrice()
                taodonhangRequest.websitePrice = proPrice
            }else{
                self.gia = "\(self.data?.originPrice ?? 0)"
//                self.tfGia.text = "\(self.data?.originPrice ?? 0)".toFormatedPrice()
                taodonhangRequest.websitePrice = self.data?.originPrice ?? 0
            }
        }
        
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
                    
                    if let price = result["price"].float, price > 0 {
                        self.tfGia.text = "\(Int(price))".toFormatedPrice()
                        self.taodonhangRequest.websitePrice = Int(price)
                    }
                    
                    if let link = result["link"].string {
                        let arr = link.splitted(by: ",")
                        for url in arr {
                            if let url2 = URL(string: url){
                                KingfisherManager.shared.retrieveImage(with: url2, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                                    if let img = image {
                                        self.stPhoto.addArrangedSubview(PhotoView(image: img))
                                        self.listImage.append(img)
                                        self.stPhoto.removeArrangedSubview(self.btnAdd)
                                        self.stPhoto.addArrangedSubview(self.btnAdd)
                                    }
                                })
                            }
                            
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
        
        
        fetchBranchAndCountry()
    }

    func fetchBranchAndCountry(){
        AlemuaApi.shared.aleApi.request(AleApi.getAllBrand())
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    if let arr = result.array {
                        self.nhomHangDr.dataSource = arr.map { $0["name"].string ?? "" }
                        self.listBranch = arr.map { $0["id"].int ?? 0 }
//                        self.nhomHangDr.selectRow(at: 0)
//                        self.tfNhomHang.text = self.nhomHangDr.dataSource[0]
                    }
//                    nhomHangDr.dataSource = []
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
        AlemuaApi.shared.aleApi.request(AleApi.getAllCountry())
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    if let arr = result.array {
                        self.quocGiaDr.dataSource = arr.map { $0["name"].string ?? "" }
                        self.listCountry = arr.map { $0["id"].int ?? 0 }
//                        self.quocGiaDr.selectRow(at: 0)
//                        self.tfQuocGia.text = self.quocGiaDr.dataSource[0]
                        
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }
    
}
