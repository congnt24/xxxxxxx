//
//  OrderDialogBaoGia2ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class OrderDialogBaoGia2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onNext(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showBaoGiaDetailDialog3()
    }
}
