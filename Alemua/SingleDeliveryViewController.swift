//
//  SingleOrderViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/20/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip

enum DeliveryType {
    case DonMua
    case BaoGia
    case DangChuyen
    case DaMua
}
class SingleDeliveryViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var tableView: UITableView!
    
    let bag = DisposeBag()
    var itemInfo: IndicatorInfo!
    var deliveryType: DeliveryType!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = "DonHangTableViewCell"
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)
        
        fetchData().bind(to: tableView.rx.items(cellIdentifier: nibName)) { (row, item, cell) in
            // TODO: Bind data here
            }.addDisposableTo(bag)
        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            DeliveryCoordinator.sharedInstance.showOrder(self.deliveryType)
            // TODO: Pass data here
            //            if self.orderType == .DonMua {
            //
            //            }
            //
            //            if self.orderType == .BaoGia {
            //                print("Bao Gia")
            //            }
            //
            //            if self.orderType == .DangChuyen {
            //                print("DangChuyen")
            //            }
            //
            //            if self.orderType == .DaMua {
            //                print("DaMua")
            //            }
            
        }).addDisposableTo(bag)
    }
    
    
    //Interact API
    func fetchData() -> Observable<[String]> {
        return Observable.just((0..<20).map { "\($0)" })
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        guard itemInfo != nil else {
            return IndicatorInfo(title: "Tab0")
        }
        return itemInfo
    }
}
