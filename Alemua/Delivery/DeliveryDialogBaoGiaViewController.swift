//
//  DeliveryDialogBaoGiaViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/28/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class DeliveryDialogBaoGiaViewController: UIViewController {
    public static var orderData: ModelOrderClientData!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onDone(_ sender: Any) {
        DeliveryCoordinator.sharedInstance.showDeliveryBaoGiaFinal(data: DeliveryDialogBaoGiaViewController.orderData!)
    }
}
