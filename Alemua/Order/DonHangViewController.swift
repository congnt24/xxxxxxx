//
//  DonHangViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SwiftyJSON
import RxSwift

class DonHangViewController: ButtonBarPagerTabStripViewController {
    var bag = DisposeBag()
    var modelQuoteData: ModelQuoteData!
    var orderData: ModelOrderClientData!
    var donhang: DonHangSubViewController!
    var baogia: OrderBaoGiaSubViewController!

    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = UIColor(hexString: "#E94F2E")!
        settings.style.buttonBarItemBackgroundColor = UIColor.clear
        settings.style.selectedBarHeight = 2
        settings.style.selectedBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        //        settings.style.buttonBarMinimumLineSpacing = 10
        //        settings.style.buttonBarItemLeftRightMargin = 0
        //change font size
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 15)
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        btlFilter.isEnabled = false
        btlFilter.plainView.isHidden = true
        fetchData()
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        donhang = UIStoryboard(name: "DonHang", bundle: nil).instantiateViewController(withClass: DonHangSubViewController.self)
        baogia = UIStoryboard(name: "DonHang", bundle: nil).instantiateViewController(withClass: OrderBaoGiaSubViewController.self)

        donhang.itemInfo = IndicatorInfo(title: "Đơn hàng")
        baogia.itemInfo = IndicatorInfo(title: "Báo giá")

        return [donhang, baogia]
    }

    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        if indexWasChanged {
            if toIndex == 0 || btlFilter.isEnabled {
                btlFilter.isEnabled = false
                btlFilter.plainView.isHidden = true
            } else {
                btlFilter.isEnabled = true
                btlFilter.plainView.isHidden = false
            }
        }
    }


    @IBOutlet weak var btlFilter: UIBarButtonItem!
    @IBAction func onFilterClick(_ sender: Any) {

    }
}

extension DonHangViewController {
    func fetchData(){
        var orderID = 0
        if HomeViewController.homeType == .delivery {
            orderID = modelQuoteData.id!
            AlemuaApi.shared.aleApi.request(AleApi.getOrderDetailsToQuote(order_id: orderID))
                .toJSON()
                .subscribe(onNext: { (res) in
                    switch res {
                    case .done(let result, _):
                        self.donhang.modelQuoteData = self.modelQuoteData
                        self.donhang.orderData = ModelOrderClientData(json: result)
                        self.baogia.orderData = ModelOrderClientData(json: result)
                        print("Cancel success")
                        break
                    case .error(let msg):
                        print("Error \(msg)")
                        break
                    }
                }).addDisposableTo(bag)
            
        }else{
            orderID = orderData.id!
            AlemuaApi.shared.aleApi.request(.getOrderDetails(orderType: 1, orderId: orderID))
                .toJSON()
                .subscribe(onNext: { (res) in
                    switch res {
                    case .done(let result, _):
                        self.donhang.orderData = ModelOrderClientData(json: result)
                        self.baogia.orderData = ModelOrderClientData(json: result)
                        print("Cancel success")
                        break
                    case .error(let msg):
                        print("Error \(msg)")
                        break
                    }
                }).addDisposableTo(bag)
        }

    }
}

