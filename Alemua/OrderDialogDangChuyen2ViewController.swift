//
//  OrderDialogDangChuyen2ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

class OrderDialogDangChuyen2ViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if HomeViewController.homeType == .order {
            lb1.text = "Thời gian giao hàng"
            lb2.text = "Tác phong làm việc"
            lb3.text = "Giá cả"
            lb3.isHidden = false
            star3.isHidden = false
        }else{
            lb1.text = "Thái độ"
            lb2.text = "Thanh toán"
            lb3.isHidden = true
            star3.isHidden = true
        }
    }
    
    @IBAction func onCamera(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
