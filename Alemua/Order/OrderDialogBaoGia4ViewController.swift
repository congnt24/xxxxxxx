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
import Toaster

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
        AlemuaApi.shared.aleApi.request(.acceptQuote(data: accept))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, let msg):
                    Toast.init(text: msg).show()
                    OrderOrderViewController.selectViewController = 2
                    OrderOrderViewController.shared.indexShouldReload.append(contentsOf: [1,2])
                    AppCoordinator.sharedInstance.navigation?.popToViewController(OrderNavTabBarViewController.sharedInstance, animated: true)
                    break
                case .error(let msg):
                    Toast.init(text: msg).show()
                    print("Error \(msg)")
                    break
                default: break
                }
            })//.addDisposableTo(bag)
    }
}
