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
import AwesomeMVVM

enum OrderType: Int {
    case DonMua = 0
    case BaoGia = 1
    case DangChuyen = 2
    case DaMua = 3
}
class SingleOrderViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    let bag = DisposeBag()
    var itemInfo: IndicatorInfo!
    var orderType: OrderType!
    let AleProvider = RxMoyaProvider<AleApi>(endpointClosure: endpointClosure)
    var datas = Variable<[ModelOrderClientData]>([])
    var currentPage = 1

    var cacheFilter = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        cacheFilter = OrderFilterViewController.orderOrderFilterType
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if cacheFilter != OrderFilterViewController.orderOrderFilterType {
            cacheFilter = OrderFilterViewController.orderOrderFilterType
            reloadPage()
        }
        if OrderOrderViewController.shared.indexShouldReload.contains(orderType.rawValue) {
            OrderOrderViewController.shared.indexShouldReload = OrderOrderViewController.shared.indexShouldReload.filter { $0 != orderType.rawValue }
            reloadPage(true)
        }
        print("SingleOrderViewController will appear \(orderType.rawValue)")
    }
    
    func refresh(_ sender: Any) {
        reloadPage()
        refreshControl.endRefreshing()
    }

    func setupTableView() {
        
        refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
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

        }).addDisposableTo(bag)
        initData()
    }
    
    func initData(){
        //Loadmore
        tableView.addInfiniteScroll { (tv) in
            // update table view
            self.fetchData(self.currentPage == 1).drive(onNext: { (results) in
                print(results)
                if results.count > 0 {
                    self.datas.value.append(contentsOf: results)
                    self.currentPage += 1
                }
            }, onDisposed: {
                LoadingOverlay.shared.hideOverlayView()
            }).addDisposableTo(self.bag)
            // finish infinite scroll animation
            tv.finishInfiniteScroll()
        }
        
        tableView.beginInfiniteScroll(true)
    }
    
    func reloadPage(_ isShowDialog: Bool = false){
        currentPage = 1
        self.fetchData(isShowDialog).drive(onNext: { (results) in
            self.datas.value = results
            self.currentPage = 2
        }).addDisposableTo(self.bag)
    }


    //Interact API
    func fetchData(_ isShowDialog: Bool = false) -> Driver<[ModelOrderClientData]> {
        if isShowDialog{
            LoadingOverlay.shared.showOverlay(view: OrderOrderViewController.shared.view)
        }
        return AleProvider.request(AleApi.getOrderFromClient(page_number: currentPage, order_type: orderType.rawValue, sort_type: (cacheFilter + 1)))//.filterSuccessfulStatusCodes()
            .flatMap { (response) -> Observable<[ModelOrderClientData]> in
                LoadingOverlay.shared.hideOverlayView()
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
