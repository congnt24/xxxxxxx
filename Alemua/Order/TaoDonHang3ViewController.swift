//
//  TaoDonHang3ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/26/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import AwesomeMVVM
import Moya
import RxSwift
import RxCocoa

class TaoDonHang3ViewController: UIViewController, IndicatorInfoProvider {
    @IBOutlet weak var itemView: ItemView!
    @IBOutlet weak var tfMuaTu: AwesomeTextField!
    @IBOutlet weak var tfGiaoDen: AwesomeTextField!
    @IBOutlet weak var tfNgay: AwesomeTextField!
    @IBOutlet weak var tfGia: AwesomeTextField!
    @IBOutlet weak var tfNote: AwesomeTextField!
    @IBOutlet weak var rateDetail: RateDetail!
    var taodonhangRequest: TaoDonHangRequest!
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        taodonhangRequest = TaoDonHang1ViewController.sharedInstance.taodonhangRequest
        // Do any additional setup after loading the view.
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Kiểm tra")
    }

    @IBAction func onGuiMuaHang(_ sender: Any) {
        if Prefs.isUserLogged {
            checkOrderAndSendRequest()
        } else {
            HomeCoordinator.sharedInstance.showLoginScreen()
        }
    }
    @IBAction func onShowMoreRate(_ sender: Any) {
        rateDetail.toggleHeight()
    }

    override func viewDidAppear(_ animated: Bool) {
        print("Appear")
        bindData()
    }

    func bindData() {
        tfMuaTu.text = taodonhangRequest.buyFrom
        tfGiaoDen.text = taodonhangRequest.deliveryTo
        tfNgay.text = taodonhangRequest.deliveryDate
        tfGia.text = "\(taodonhangRequest.websitePrice ?? 0)"
        tfNote.text = taodonhangRequest.note
    }


    func checkOrderAndSendRequest() {
        //TODO: Send request
        AlemuaApi.shared.aleApi.request(.createOrder(data: taodonhangRequest)).subscribe({ (event) in
            switch event {
            case .next(let ele):
                print("SUCCESS \(ele)")
                OrderCoordinator.sharedInstance.showOrderTabAfterFinishTaoDonHang()
                break
            case .error(let err):
                print("ERROR: \(err)")
                break
            default:

                break
            }
        }).addDisposableTo(bag)
    }

}
