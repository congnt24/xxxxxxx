//
//  DialogSetWeight.swift
//  Alemua
//
//  Created by Cong Nguyen on 9/9/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import RxSwift

class DialogSetWeight: UIViewController {
    let bag = DisposeBag()
    @IBOutlet weak var tfWeight: UITextField!
    
    var txtWeight = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tfWeight.text = txtWeight
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onNext(_ sender: Any) {
        DeliveryBaoGiaFinalViewController.shared.rateDetail.onUpdateWeight(weight: tfWeight.text)
        
    }
}
