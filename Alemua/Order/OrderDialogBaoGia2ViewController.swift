//
//  OrderDialogBaoGia2ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class OrderDialogBaoGia2ViewController: UIViewController {
    var order_id: Int?
    var quoteId: Int!
    @IBOutlet weak var lbSoDonHang: UILabel!
    @IBOutlet weak var btnDonHang: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbSoDonHang.text = "\(order_id ?? 0)"
        btnDonHang.setTitle("● Thanh toán 50% giá trị đơn hàng \(order_id ?? 0)", for: .normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onNext(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showBaoGiaDetailDialog3(id: order_id, quoteId: quoteId)
    }
}
