//
//  OrderDialogBaoGia1ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class OrderDialogBaoGia1ViewController: UIViewController {

    @IBOutlet weak var radioGroup: AwesomeRadioGroup!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onNext(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showBaoGiaDetailDialog2(index: radioGroup.checkedPosition)
        
        
        let parent = OrderOrderCoordinator.sharedInstance.navigation?.topViewController
        if radioGroup.checkedPosition == 0 {
            AwesomeDialog.shared.show(vc: parent, name: "DonHang", identify: "OrderDialogBaoGia2ViewController")
        } else {
            AwesomeDialog.shared.show(vc: parent, name: "DonHang", identify: "OrderDialogBaoGia4ViewController")
        }
    }
}
