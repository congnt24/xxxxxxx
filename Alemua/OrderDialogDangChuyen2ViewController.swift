//
//  OrderDialogDangChuyen2ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import KMPlaceholderTextView
import MobileCoreServices
import RxSwift

class OrderDialogDangChuyen2ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbNguoiMuaHang: UILabel!
    @IBOutlet weak var tvComment: KMPlaceholderTextView!
    @IBOutlet weak var grReview: UIStackView!

    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var star1: StarView!
    @IBOutlet weak var lb2: UILabel!
    @IBOutlet weak var star2: StarView!
    @IBOutlet weak var lb3: UILabel!
    @IBOutlet weak var star3: StarView!
    @IBOutlet weak var camera: UIButton!

    let bag = DisposeBag()
    var ratingId: Int?
    var userPostName: String?
    var userPostPhoto: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if HomeViewController.homeType == .order {
            lb1.text = "Thời gian giao hàng"
            lb2.text = "Tác phong làm việc"
            lb3.text = "Giá cả"
            lb3.isHidden = false
            star3.isHidden = false
            lbNguoiMuaHang.text = "Người bán hàng"
        } else {
            lb1.text = "Thái độ"
            lb2.text = "Thanh toán"
            lbNguoiMuaHang.text = "Người mua hàng"
            lb3.isHidden = true
            star3.isHidden = true
        }
        lbName.text = Prefs.userName
        avatar.kf.setImage(with: URL(string: Prefs.photo), placeholder: UIImage(named: "no_image"))
    }

    @IBAction func onCamera(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
//        print("open camera")
//        PictureHelper.pickPhoto(delegate: self, vc: self)
        
        PictureHelper.showDialogChoosePhoto(delegate: self, vc: self)

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString

        self.dismiss(animated: true, completion: nil)

        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
            as! UIImage

            self.camera.setImage(image, for: .normal)

        }
    }

    @IBAction func onDone(_ sender: Any) {
        if HomeViewController.homeType == .delivery {
            let rateData = RateForClient()
            rateData.userAttitudeRating = star1.number
            rateData.userPaymentRating = star2.number
            rateData.ratingId = ratingId ?? 0
            
            //upload image
            //send rating
            AlemuaApi.shared.aleApi.request(AleApi.rateForClient(data: rateData))
                .toJSON()
                .subscribe(onNext: { (res) in
                    switch res {
                    case .done(_):
                        AppCoordinator.sharedInstance.navigation?.popToViewController(DeliveryNavTabBarViewController.sharedInstance, animated: true)
                        print("Cancel success")
                        break
                    case .error(let msg):
                       AppCoordinator.sharedInstance.navigation?.popToViewController(DeliveryNavTabBarViewController.sharedInstance, animated: true)
                        print("Error \(msg)")
                        break
                    default: break
                    }
                }).addDisposableTo(bag)

        } else {
            let rateData = DeliveredOrderData()
            rateData.shipperTimeRating = star1.number
            rateData.shipperAttitudeRating = star2.number
            rateData.shipperPaymentRating = star3.number
            rateData.orderId = ratingId ?? 0
            rateData.shipperComment = tvComment.text
            AlemuaApi.shared.aleApi.request(AleApi.setDeliveredOrder(data: rateData))
                .toJSON()
                .subscribe(onNext: { (res) in
                    OrderOrderViewController.shared.indexShouldReload.append(2)
                    switch res {
                    case .done(_):
                        AppCoordinator.sharedInstance.navigation?.popToViewController(OrderNavTabBarViewController.sharedInstance, animated: true)
                        print("Cancel success")
                        break
                    case .error(let msg):
                        AppCoordinator.sharedInstance.navigation?.popToViewController(OrderNavTabBarViewController.sharedInstance, animated: true)
                        print("Error \(msg)")
                        break
                    default: break
                    }
                }).addDisposableTo(bag)

        }

    }
}
