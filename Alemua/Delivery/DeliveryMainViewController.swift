//
//  DeliveryMain.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxCocoa
import RxSwift
import Moya
import SwiftyJSON
import UIScrollView_InfiniteScroll

class DeliveryMainViewController: BaseViewController {
    let bag = DisposeBag()

    @IBOutlet weak var tfLink: AwesomeTextField!
    var datas = Variable<[ModelQuoteData]>([])
    var currentPage = 1

    @IBOutlet weak var tableView: UITableView!
    
    
    var refreshControl: UIRefreshControl!
    
    func refresh(_ sender: Any) {
        reloadPage()
        refreshControl.endRefreshing()
    }
    
    override func bindToViewModel() {
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        let nibName = "DeliveryTableViewCell"
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)

        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: nibName)) { (row, item, cell) in
            (cell as! DeliveryTableViewCell).bindData(data: item)
            (cell as! DeliveryTableViewCell).onClickBaoGia = {
                DeliveryCoordinator.sharedInstance.showDeliveryDonHang(data: item)
            }
        }.addDisposableTo(bag)
        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            DeliveryCoordinator.sharedInstance.showDeliveryDonHang(data: self.datas.value[ip.row])
        }).addDisposableTo(bag)

        tableView.addInfiniteScroll { (tv) in
            // update table view
            self.fetchData().drive(onNext: { (results) in
                if results.count > 0 {
                    self.currentPage += 1
                    self.datas.value.append(contentsOf: results)
                }
            }).addDisposableTo(self.bag)
            // finish infinite scroll animation
            tv.finishInfiniteScroll()
        }

        tableView.beginInfiniteScroll(true)
    }

    func reloadPage(){
        currentPage = 1
        self.fetchData().drive(onNext: { (results) in
            if results.count > 0 {
                self.currentPage += 1
                self.datas.value = results
                
            }
        }).addDisposableTo(self.bag)
    }
    //Interact API
    func fetchData() -> Driver<[ModelQuoteData]> {
        return AlemuaApi.shared.aleApi.request(.getQuoteForShipper(page_number: self.currentPage)).filterSuccessfulStatusCodes()
            .flatMap { (response) -> Observable<[ModelQuoteData]> in
                let obj = ModelQuoteResponse(json: JSON(response.data))
                return Observable.from(optional: obj.result)
            }.asDriver(onErrorJustReturn: [])
    }

}
