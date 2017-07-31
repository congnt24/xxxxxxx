//
//  TaoDonHang3ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/26/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import AwesomeMVVM

class TaoDonHang3ViewController: UIViewController, IndicatorInfoProvider {
    @IBOutlet weak var tfMuaTu: AwesomeTextField!
    @IBOutlet weak var tfGiaoDen: AwesomeTextField!
    @IBOutlet weak var tfNgay: AwesomeTextField!
    @IBOutlet weak var tfNote: AwesomeTextField!
    var taodonhangRequest: TaoDonHangRequest!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //taodonhangRequest = (parent as! TaoDonHangViewController).taodonhangRequest
        // Do any additional setup after loading the view.
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Kiểm tra")
    }

    @IBAction func onGuiMuaHang(_ sender: Any) {
        if Prefs.isUserLogged {
            OrderCoordinator.sharedInstance.showOrderTabAfterFinishTaoDonHang()
        } else {
            HomeCoordinator.sharedInstance.showLoginScreen()
        }
    }


}
