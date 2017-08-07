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

class TaoDonHang1ViewController: UIViewController, IndicatorInfoProvider, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tfTenSP: AwesomeTextField!
    @IBOutlet weak var tfMota: AwesomeTextField!
    @IBOutlet weak var tfWebsite: AwesomeTextField!
    @IBOutlet weak var tfGia: AwesomeTextField!
    @IBOutlet weak var tfCode: AwesomeTextField!
    @IBOutlet weak var stSoLuong: StepperView!
    @IBOutlet weak var grSelect: AwesomeRadioGroup!
    @IBOutlet weak var stPhoto: UIStackView!

    @IBOutlet weak var btnAdd: UIButton!

    var taodonhangRequest = TaoDonHangRequest()
    static var sharedInstance: TaoDonHang1ViewController!
    let bag = DisposeBag()
    var listImage = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        TaoDonHang1ViewController.sharedInstance = self
//         Do any additional setup after loading the view.
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
                        case .done(let result):
                            LoadingOverlay.shared.hideOverlayView()
                            self.taodonhangRequest.photo = result.string
                            TaoDonHangViewController.sharedInstance.moveToViewController(at: 1)
                            print("Cancel success")
                            break
                        case .error(let msg):
                            print("Error \(msg)")
                            break
                        default: break
                        }
                    }).addDisposableTo(bag)
            } else {
                TaoDonHangViewController.sharedInstance.moveToViewController(at: 1)

            }
        } else {
            print("ERROR")
        }
    }

    func setData() {
        taodonhangRequest.productName = tfTenSP.text
        taodonhangRequest.productDescription = tfMota.text
        taodonhangRequest.websiteUrl = tfWebsite.text
        taodonhangRequest.websitePrice = Int(tfGia.text!)
        taodonhangRequest.promotionCode = tfCode.text
        taodonhangRequest.quantity = stSoLuong.number
        taodonhangRequest.productOption = grSelect.checkedPosition
        taodonhangRequest.numberProduct = stSoLuong.number
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
            stPhoto.removeArrangedSubview(btnAdd)
            listImage.append(image)
            stPhoto.addArrangedSubview(PhotoView(image: image))
            //            self.camera.setImage(image, for: .normal)
            stPhoto.addArrangedSubview(btnAdd)

        }
    }


}
