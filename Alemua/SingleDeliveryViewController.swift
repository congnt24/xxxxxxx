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

class SingleDeliveryViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    let bag = DisposeBag()
    var itemInfo: IndicatorInfo!
    var deliveryType: DeliveryType!
    let AleProvider = RxMoyaProvider<AleApi>(endpointClosure: endpointClosure)
    var datas = Variable<[ModelOrderClientData]>([])
    var currentPage = 1
    var cacheFilter = -1
    
    public static var shouldReloadPage = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if SingleDeliveryViewController.shouldReloadPage > -1 {
            print("run 1")
            reloadPage()
            SingleDeliveryViewController.shouldReloadPage = -1
        }else
        if cacheFilter != OrderFilterViewController.deliveryOrderFilterType {
            print("run 2")
            cacheFilter = OrderFilterViewController.deliveryOrderFilterType
            reloadPage()
        }else
        if DeliveryOrderViewController.indexShouldReload.contains(deliveryType.rawValue - 1) {
            print("run 3")
            DeliveryOrderViewController.indexShouldReload = DeliveryOrderViewController.indexShouldReload.filter { $0 != (deliveryType.rawValue - 1) }
            reloadPage()
        }
        print("SingleOrderViewController will appear \(deliveryType.rawValue)")
    }
    
    func refresh(_ sender: Any) {
        print("reload")
        reloadPage()
        refreshControl.endRefreshing()
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
            
        }).addDisposableTo(bag)
        initData()
    }
    
    func initData(){
        //Loadmore
        tableView.addInfiniteScroll { (tv) in
            // update table view
            self.fetchData( self.currentPage != 1)
            // finish infinite scroll animation
            tv.finishInfiniteScroll()
        }
        
        tableView.beginInfiniteScroll(true)
    }
    
    func reloadPage(){
        currentPage = 1
        self.fetchData(true)
    }

    
    //Interact API
    func fetchData(_ isReload: Bool = false) {
//        if deliveryType.rawValue > 1 {
        if !isReload {
            LoadingOverlay.shared.showOverlay(view: DeliveryOrderViewController.shared.view)
        }
        return AleProvider.request(AleApi.getOrderFromShipper(page_number: currentPage, order_type: deliveryType.rawValue, sort_type: (cacheFilter + 1))).toJSON()
            .subscribe(onNext: { (res) in
                LoadingOverlay.shared.hideOverlayView()
                switch res {
                case .done(let result, _):
                    if let array = result.array, array.count > 0 {
                        let arrs = array.map { ModelOrderClientData(json: $0) }
                        if self.currentPage == 1 {
                            self.datas.value = arrs
                        }else{
                            for item in arrs {
                                self.datas.value.append(item)
                            }
                        }
                        self.currentPage += 1
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }, onDisposed: {
                LoadingOverlay.shared.hideOverlayView()
            }).addDisposableTo(bag)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        guard itemInfo != nil else {
            return IndicatorInfo(title: "Tab0")
        }
        return itemInfo
    }
}
