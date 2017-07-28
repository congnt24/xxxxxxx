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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func onCamera(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
