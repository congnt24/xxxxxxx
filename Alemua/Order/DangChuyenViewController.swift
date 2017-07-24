//
//  DangChuyenViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class DangChuyenViewController: UIViewController {

    @IBOutlet weak var uiMoreDetails: AwesomeToggleViewByHeight!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onToggleMoreDetails(_ sender: Any) {
        uiMoreDetails.toggleHeight()
    }

}
