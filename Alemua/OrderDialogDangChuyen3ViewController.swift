//
//  OrderDialogDangChuyen3ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import KMPlaceholderTextView
import SwiftyJSON
import RxSwift
import Toaster

class OrderDialogDangChuyen3ViewController: UIViewController {
    var orderId: Int!
    @IBOutlet weak var tvLydo: KMPlaceholderTextView!
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onDone(_ sender: Any) {
        //Cancel
        let cancel = CancelOrderRequest()
        cancel.orderId = orderId
        cancel.cancelReason = tvLydo.text
        LoadingOverlay.shared.showOverlay(view: view)
        AlemuaApi.shared.aleApi.request(.cancelOrder(data: cancel))
        .filterSuccessfulStatusCodes()
        .subscribe(onNext: { (response) in
            let json = JSON(response.data)
            print(json)
            if json["code"] == 200 {
                print("Cancel success")
                AppCoordinator.sharedInstance.navigation?.popToViewController(OrderNavTabBarViewController.sharedInstance, animated: true)
            }else{
                print("Error")
            }
        }, onDisposed: {
            LoadingOverlay.shared.hideOverlayView()
        })//.addDisposableTo(bag)
    }
}
