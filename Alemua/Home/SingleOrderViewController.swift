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

enum OrderType: Int {
    case DonMua = 0
    case BaoGia = 1
    case DangChuyen = 2
    case DaMua = 3
}
class SingleOrderViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var tableView: UITableView!

    let bag = DisposeBag()
    var itemInfo: IndicatorInfo!
    var orderType: OrderType!
    let AleProvider = RxMoyaProvider<AleApi>(endpointClosure: endpointClosure)
    var datas = Variable<[ModelOrderClientData]>([])
    var currentPage = 1


    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
        let nibName = "DonHangTableViewCell"
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)
        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: nibName)) { (row, item, cell) in
            (cell as! DonHangTableViewCell).bindData(data: item)
            if self.orderType.rawValue < 2 {
                (cell as! DonHangTableViewCell).invisibleGiaMua()
            }
        }.addDisposableTo(bag)
        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            OrderCoordinator.sharedInstance.showOrder(self.orderType, data: self.datas.value[ip.row])
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
            self.fetchData().drive(onNext: { (results) in
                print(results)
                if results.count > 0 {
                    for result in results {
                        self.datas.value.append(result)
                    }
                    self.currentPage += 1
                }
            }).addDisposableTo(self.bag)
            // finish infinite scroll animation
            tv.finishInfiniteScroll()
        }

        tableView.beginInfiniteScroll(true)
    }


    //Interact API
    func fetchData() -> Driver<[ModelOrderClientData]> {
        return AleProvider.request(AleApi.getOrderFromClient(page_number: currentPage, order_type: orderType.rawValue)).filterSuccessfulStatusCodes()
            .flatMap { (response) -> Observable<[ModelOrderClientData]> in
                let json = JSON(data: response.data)
                let obj = ModelOrderClientResponse(json: json)
                print(json)
                return Observable.from(optional: obj.result)
            }.asDriver(onErrorJustReturn: [])
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        guard itemInfo != nil else {
            return IndicatorInfo(title: "Tab0")
        }
        return itemInfo
    }
}
