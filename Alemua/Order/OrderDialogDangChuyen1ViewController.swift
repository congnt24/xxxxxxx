//
//  OrderDialogDangChuyen1ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import SwiftyJSON
import RxSwift

class OrderDialogDangChuyen1ViewController: UIViewController {
    var user_post_id: Int!
    var sdt: String!
    var name: String!
    @IBOutlet weak var tfTen: AwesomeTextField!
    @IBOutlet weak var tfSDT: AwesomeTextField!
    @IBOutlet weak var tfNoidung: AwesomeTextField!
    
    var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        tfTen.text = name
        tfSDT.text = sdt
        // Do any additional setup after loading the view.
    }


    @IBAction func onBaoXau(_ sender: Any) {
        //report
        let report = ReportUserRequest()
        report.userReport = user_post_id
        report.reportContent = tfNoidung.text!
        AlemuaApi.shared.aleApi.request(.reportUser((data: report)))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done( _):
                    AppCoordinator.sharedInstance.navigation?.popViewController()
                    print("Cancel success")
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                default: break
                }
            }).addDisposableTo(bag)
    }
}
