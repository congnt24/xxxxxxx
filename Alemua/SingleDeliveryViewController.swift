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
import Moya
import SwiftyJSON

class SingleDeliveryViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var tableView: UITableView!
    
    let bag = DisposeBag()
    var itemInfo: IndicatorInfo!
    var deliveryType: DeliveryType!
    let AleProvider = RxMoyaProvider<AleApi>(endpointClosure: endpointClosure)
    var datas = Variable<[ModelOrderClientData]>([])
    var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
        let nibName = "DonHangTableViewCell"
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)
        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: nibName)) { (row, item, cell) in
            (cell as! DonHangTableViewCell).bindData(data: item)
            }.addDisposableTo(bag)
        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            DeliveryCoordinator.sharedInstance.showOrder(self.deliveryType, data: self.datas.value[ip.row])
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
        
        //Loadmore
        tableView.addInfiniteScroll { (tv) in
            // update table view
            self.fetchData()
            // finish infinite scroll animation
            tv.finishInfiniteScroll()
        }
        
        tableView.beginInfiniteScroll(true)
    }
    
    
    //Interact API
    func fetchData() {
        return AleProvider.request(AleApi.getOrderFromShipper(page_number: currentPage, order_type: deliveryType.rawValue)).toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result):
                    if let array = result.array, array.count > 0 {
                        self.currentPage += 1
                        let arrs = array.map { ModelOrderClientData(json: $0) }
                        for item in arrs {
                            self.datas.value.append(item)
                        }
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
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
