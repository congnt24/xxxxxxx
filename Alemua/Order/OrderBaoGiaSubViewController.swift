//
//  BaoGiaSubViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/23/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RxCocoa
import RxSwift

class OrderBaoGiaSubViewController: UIViewController, IndicatorInfoProvider {

    var orderData: ModelOrderClientData? {
        didSet {
            if let orderData = orderData, let quotes = orderData.quotes {
                quoteData.value = quotes
            }
        }
    }

    var quoteData = Variable<[ModelOrderBaoGiaData]>([])

    @IBOutlet weak var tableView: UITableView!

    let bag = DisposeBag()
    var itemInfo: IndicatorInfo!
    var orderType: OrderType!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName: String
        if HomeViewController.homeType == .order {
            nibName = "BaoGiaTableViewCell"
        } else {
            nibName = "BaoGiaDeliveryTableViewCell"
        }
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)

        quoteData.asObservable().bind(to: tableView.rx.items(cellIdentifier: nibName)) { (row, item, cell) in
            // TODO: Bind data here
            if HomeViewController.homeType == .order {
                (cell as! BaoGiaTableViewCell).bindData(data: item)
            } else {
                (cell as! BaoGiaDeliveryTableViewCell).bindData(data: item)
            }
        }.addDisposableTo(bag)

        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            if HomeViewController.homeType == .order {
                OrderOrderCoordinator.sharedInstance.showBaoGiaDetail(data: self.quoteData.value[ip.row], orderData: self.orderData!)
            }

        }).addDisposableTo(bag)
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        guard itemInfo != nil else {
            return IndicatorInfo(title: "Tab0")
        }
        return itemInfo
    }
}
