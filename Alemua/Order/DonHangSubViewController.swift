//
//  DonHangSubViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/23/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DonHangSubViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var btnDeliveryBaoGia: AwesomeCloseButton!
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

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        guard itemInfo != nil else {
            return IndicatorInfo(title: "Tab0")
        }
        return itemInfo
    }
    
    @IBAction func onClickDeliveryBaoGia(_ sender: Any) {
        //TODO: Check if not logged -> Login else  if chọn chỉ mua khi có giảm giá -> Dialog -> DeliveryBaoGiaFinalViewController
//        AwesomeDialog.shared.show(vc: self, name: "DonHang", identify: "DeliveryDialogBaoGiaViewController")
        DeliveryCoordinator.sharedInstance.showDeliveryBaoGiaFinal()
        
    }
    
}
