//
//  DonHangSubViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/23/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import AwesomeMVVM

class DonHangSubViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var btnDeliveryBaoGia: AwesomeCloseButton!
    
    @IBOutlet weak var itemView: ItemView!
    @IBOutlet weak var lbMuaTu: AwesomeTextField!
    @IBOutlet weak var lbGiaoDen: AwesomeTextField!
    @IBOutlet weak var lbNgay: AwesomeTextField!
    @IBOutlet weak var lbGia: AwesomeTextField!
    @IBOutlet weak var lbMota: AwesomeTextField!
    @IBOutlet weak var lbLuaChon: AwesomeTextField!
    
    
    
    var itemInfo: IndicatorInfo!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func viewWillAppear(_ animated: Bool) {
        if HomeViewController.homeType == .order {
            btnDeliveryBaoGia.isHidden = true
        } else {
            btnDeliveryBaoGia.isHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        guard itemInfo != nil else {
            return IndicatorInfo(title: "Tab0")
        }
        return itemInfo
    }

    @IBAction func onClickDeliveryBaoGia(_ sender: Any) {
        //TODO: Check if not logged -> Login else  if chọn chỉ mua khi có giảm giá -> Dialog -> DeliveryBaoGiaFinalViewController
//        AwesomeDialog.shared.show(vc: self, name: "DonHang", identify: "DeliveryDialogBaoGiaViewController")

        if Prefs.isUserLogged {
            DeliveryCoordinator.sharedInstance.showDeliveryBaoGiaFinal()
        } else {
            HomeCoordinator.sharedInstance.showLoginScreen()
        }

    }

}
