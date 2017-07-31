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
    @IBOutlet weak var danhgia1: DanhGiaView!
    @IBOutlet weak var danhgia2: DanhGiaView!
    @IBOutlet weak var itemView: ItemView!
    
    @IBOutlet weak var tfMuatu: AwesomeTextField!
    @IBOutlet weak var tfGiaoden: AwesomeTextField!
    @IBOutlet weak var tfNgay: AwesomeTextField!
    @IBOutlet weak var tfGia: AwesomeTextField!
    @IBOutlet weak var tfMota: AwesomeTextField!
    @IBOutlet weak var tfLuachon: AwesomeTextField!
    override func bindToViewModel() {
        userView.toggleView = {
            self.uiMoreDetail.toggleHeight()
        }
    }

    @IBAction func onDatMua(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showBaoGiaDetailDialog1()
    }
}
