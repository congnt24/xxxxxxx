//
//  OrderDialogBaoGia3ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift

class OrderDialogBaoGia3ViewController: UIViewController {
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
        accept.transactionOption = 1
        AlemuaApi.shared.aleApi.request(.acceptQuote(data: accept)).filterSuccessfulStatusCodes()
            .subscribe(onNext: { (response) in
                let json = JSON(response.data)
                print(json)
                if json["code"] == 200 {
                    //success
                    AppCoordinator.sharedInstance.navigation?.popViewController()
                }else{
                    //error
                    print("error")
                }
            }).addDisposableTo(bag)
    }
}
