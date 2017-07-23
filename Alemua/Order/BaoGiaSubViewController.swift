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

class BaoGiaSubViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var tableView: UITableView!
    
    let bag = DisposeBag()
    var itemInfo: IndicatorInfo!
    var orderType: OrderType!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = "BaoGiaTableViewCell"
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)
        
        fetchData().bind(to: tableView.rx.items(cellIdentifier: nibName)) { (row, item, cell) in
            // TODO: Bind data here
            }.addDisposableTo(bag)
        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            print("HEllo")
            OrderCoordinator.sharedInstance.showBaoGiaDetail()
            
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
