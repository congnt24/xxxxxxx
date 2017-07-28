//
//  OrderBaoGiaDetailSubViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM

class OrderBaoGiaDetailSubViewController: BaseViewController {

    @IBOutlet weak var userView: UserView!
    @IBOutlet weak var uiMoreDetail: AwesomeToggleViewByHeight!
    
    override func bindToViewModel() {
        userView.toggleView = {
            self.uiMoreDetail.toggleHeight()
        }
    }

    @IBAction func onDatMua(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showBaoGiaDetailDialog1()
    }
}
