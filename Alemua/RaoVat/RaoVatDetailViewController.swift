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
import Toaster
import Kingfisher
import ImageSlideshow
import MessageUI

class RaoVatDetailViewController: BaseViewController {
    var bag = DisposeBag()

    @IBOutlet weak var imageSlider: ImageSlideshow!
    @IBOutlet weak var btnFav: CheckedButton!
    @IBOutlet weak var btnShare: CheckedButton!

    var data: ProductResponse!
    var currrentPage = 1
    var relateDatas = Variable<[ProductResponse]>([])

    var productDetail: ProductDetailResponse? {
        didSet {
            if let data = productDetail {
                lbName.text = data.title
//                distance.text = "\(data.distance ?? 0)"
                if data.productType! == 1 {
                    lbHandMoi.text = "Hàng mới"
                } else if data.productType! == 2 {
                    lbHandMoi.text = "Hàng sang tay"
                } else {
                    lbHandMoi.text = "Đã qua sử dụng"
                }
                lbOldPrice.setText(str: "\(data.price!)".toRaoVatPriceFormat().toFormatedPrice())
                lbNewPrice.text = "\(data.price! * (100 - (data.promotion ?? 0)) / 100)".toRaoVatPriceFormat().toFormatedPrice()
                lbAddress.text = data.transactionAddress
                lbDesc.text = data.descriptionValue
                userView.bindData(name: data.userName, address: data.userAddress, photo: data.userPhoto)

                //photo

                if let p = data.photo {
                    let photos = p.splitted(by: ",")
                    imageSlider.setImageInputs(photos.map { KingfisherSource(urlString: $0)! })
                    
                }
                btnFav.onChange = {bo in
                    if !bo {
                        self.btnFav.borderColor = UIColor.init(hexString: "#E94F2E")
                        self.btnFav.setTitleColor(UIColor.init(hexString: "#E94F2E"), for: .normal)
                    }else{
                        self.btnFav.borderColor = UIColor.lightGray
                        self.btnFav.setTitleColor(UIColor.lightGray, for: .normal)
                    }
                }
                
                btnShare.onChange = {bo in
                    if !bo {
                        self.btnShare.borderColor = UIColor.init(hexString: "#E94F2E")
                        self.btnShare.setTitleColor(UIColor.init(hexString: "#E94F2E"), for: .normal)
                    }else{
                        self.btnShare.borderColor = UIColor.lightGray
                        self.btnShare.setTitleColor(UIColor.lightGray, for: .normal)
                    }
                }
                btnFav.isChecked = !(data.isLike! == 1)
                btnShare.isChecked = !(data.isSafe! == 1)
                
                btnFav.onChange = {bo in
                    if !bo {
                        self.btnFav.borderColor = UIColor.init(hexString: "#E94F2E")
                        self.btnFav.setTitleColor(UIColor.init(hexString: "#E94F2E"), for: .normal)
                    }else{
                        self.btnFav.borderColor = UIColor.lightGray
                        self.btnFav.setTitleColor(UIColor.lightGray, for: .normal)
                    }
                    self.btnLike("")
                }
                
                btnShare.onChange = {bo in
                    if !bo {
                        self.btnShare.borderColor = UIColor.init(hexString: "#E94F2E")
                        self.btnShare.setTitleColor(UIColor.init(hexString: "#E94F2E"), for: .normal)
                    }else{
                        self.btnShare.borderColor = UIColor.lightGray
                        self.btnShare.setTitleColor(UIColor.lightGray, for: .normal)
                    }
                    self.onShare("")
                }
            }
        }
    }

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbNewPrice: UILabel!
    @IBOutlet weak var lbOldPrice: StrikeThroughLabel!
    @IBOutlet weak var lbHandMoi: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var userView: RaoVatUserView!
    @IBOutlet weak var lbDesc: UILabel!
    @IBOutlet weak var vcRelate: UICollectionView!
    override func bindToViewModel() {
        //increase view
        RaoVatService.shared.api.request(RaoVatApi.increaseView(adv_detail_id: data.id!))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(self.bag)
        
        
        
        
        imageSlider.activityIndicator = DefaultActivityIndicator(style: .whiteLarge, color: UIColor.init(hexString: "#E94F2E"))
        relateDatas.asObservable().bind(to: vcRelate.rx.items(cellIdentifier: "RelateCollectionViewCell")) { (index, item, cell) in
            (cell as! RelateCollectionViewCell).bindData(data: item)
        }.addDisposableTo(bag)

        vcRelate.rx.itemSelected.subscribe(onNext: { (ip) in

        }).addDisposableTo(bag)
        fetchDetail()
    }
    func fetchDetail() {
        LoadingOverlay.shared.showOverlay(view: view)
        RaoVatService.shared.api.request(RaoVatApi.getAdvDetails(adv_detail_id: data.id!, latitude: data.latitude, longitude: data.longitude))
            .toJSON()
            .subscribe(onNext: { (res) in
                LoadingOverlay.shared.hideOverlayView()
                switch res {
                case .done(let result, _):
                    self.productDetail = ProductDetailResponse(json: result)
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)

        RaoVatService.shared.api.request(RaoVatApi.getRelatedAdvs(sub_category_id: data.subCategoryId!, page_number: currrentPage))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    if let arr = result.array {
                        self.relateDatas.value.append(contentsOf: arr.map { ProductResponse(json: $0) })
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)


    }
    override func responseFromViewModel() {

    }
    @IBAction func onBinhLuan(_ sender: Any) {
        RaoVatCoordinator.sharedInstance.showRaoVatComment(data: productDetail!)
    }
    @IBAction func onGoiDien(_ sender: Any) {
        sendMessage(numbers: [productDetail?.userPhoneNumber ?? ""])
    }
    @IBAction func onGuiSMS(_ sender: Any) {
        call(number: productDetail?.userPhoneNumber ?? "")
    }
    @IBAction func btnLike(_ sender: Any) {
        RaoVatService.shared.api.request(RaoVatApi.addFavorite(adv_detail_id: data.id!))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, let msg):
                    Toast.init(text: msg).show()
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)

    }
    @IBAction func obMap(_ sender: Any) {
        RaoVatCoordinator.sharedInstance.showMapViewController(data: data)
    }
    @IBAction func onShare(_ sender: Any) {
    }
}



extension RaoVatDetailViewController: MFMessageComposeViewControllerDelegate {
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult){
        
        switch (result) {
            
        case .cancelled:
            break
            
        case .failed:
            
            break
            
        case .sent:
            
            break
            
        default:
            break
        }
        
        self.dismiss(animated: true) { () -> Void in
            
        }
    }
    
    func sendMessage(numbers: [String]) {
        
        let messageVC = MFMessageComposeViewController()
        
//        messageVC.body = "My first custom SMS";
        messageVC.recipients = ["0123456789"]
        messageVC.messageComposeDelegate = self;
        
        self.present(messageVC, animated: false, completion: nil)
    }
    func call(number: String) {
        UIApplication.shared.openURL(URL(string: "tel://\(number)")!)
    }
}


class RelateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var lbNewPrice: UILabel!
    @IBOutlet weak var lbOldPrice: StrikeThroughLabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var btnPromo: UIButton!

    func bindData(data: ProductResponse) {
        if let p = data.photo, p != "" {
            let arr = p.splitted(by: ",")
            photo.kf.setImage(with: URL(string: arr[0]), placeholder: UIImage(named: "no_image"))
        }
        lbName.text = data.title
        lbOldPrice.setText(str: "\(data.price!)".toRaoVatPriceFormat().toFormatedPrice())
        lbNewPrice.text = "\(data.price! * (100 - (data.promotion ?? 0)) / 100)".toRaoVatPriceFormat().toFormatedPrice()
        btnPromo.setTitle("\(data.promotion ?? 0)%", for: .normal)
        
    }
}

