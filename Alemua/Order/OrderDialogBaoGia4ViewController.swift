//
//  OrderDialogBaoGia4ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift

class OrderDialogBaoGia4ViewController: UIViewController {
    var order_id: Int?
    var quoteId: Int!
    var bag = DisposeBag()
    @IBOutlet weak var lbSoDonHang: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbSoDonHang.text = "\(order_id ?? 0)"
        // Do any additional setup after loading the view.
    }


    @IBAction func onDone(_ sender: Any) {
        let accept = AcceptQuoteRequest()
        accept.orderId = order_id
        accept.quoteId = quoteId
        accept.transactionOption = 2
        AlemuaApi.shared.aleApi.request(.acceptQuote(data: accept)).filterSuccessfulStatusCodes()
        .subscribe(onNext: { (response) in
            let json = JSON(response.data)
            print(json)
            if json["code"] == 200 {
                //success
//                AppCoordinator.sharedInstance.navigation?.popViewController()
                OrderOrderViewController.shared.selectViewController = 2
                AppCoordinator.sharedInstance.navigation?.popToViewController(OrderNavTabBarViewController.sharedInstance, animated: true)
            }else{
                //error
                print("error")
            }
        }).addDisposableTo(bag)
    }
}
