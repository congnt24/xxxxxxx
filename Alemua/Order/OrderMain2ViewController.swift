//
//  OrderMain2ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import Moya
import RxDataSources
import RxCocoa
import RxSwift
import SwiftyJSON
import UIScrollView_InfiniteScroll


enum OrderSection: Int {
    case sphot = 1
    case spgiamgia = 2
}

class OrderMain2ViewController: UIViewController {
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    var section: OrderSection = .spgiamgia
    let aleApi = RxMoyaProvider<AleApi>(endpointClosure: endpointClosure)
    var currentPage = 1
    var bag = DisposeBag()
    var datas = Variable<[ModelOrderData]>([])
    
    
    var sectionName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.title = sectionName
        if sectionName == "Sản phẩm Hot" {
            section = .sphot
        }
        setupTable()
        
        
        // TODO: Bind data to tableview
        
    }
    @IBAction func onClickFilter(_ sender: Any) {
    }
}

// MARK: Handle setup tableview
extension OrderMain2ViewController {
    func setupTable(){
        //register nib
        tableView.register(UINib(nibName: "OrderViewCell", bundle: nil), forCellReuseIdentifier: "OrderViewCell")
        //Configure cell
        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: "OrderViewCell")){ (row, item, cell) in
            (cell as! OrderViewCell).bindData(item: item)
            }.addDisposableTo(bag)
        //Loadmore
        tableView.addInfiniteScroll { (tv) in
            // update table view
            self.fetchData().drive(onNext: { (results) in
                for result in results {
                    self.datas.value.append(result)
                    self.currentPage += 1
                }
            }).addDisposableTo(self.bag)
            // finish infinite scroll animation
            tv.finishInfiniteScroll()
        }
        
        tableView.beginInfiniteScroll(true)
    }
    
    func fetchData() -> Driver<[ModelOrderData]>{ // fetch data and map to ProductData
        return aleApi.request(.getProducts(type: section.rawValue, page: currentPage))
            .filterSuccessfulStatusCodes().flatMap({ (response) -> Observable<[ModelOrderData]> in
                let json = JSON(response.data)
                let responseObj = ModelMainOrderResponse(json: json)
                return Observable.from(optional: responseObj.result)
            }).asDriver(onErrorJustReturn: [])
    }
    
}


// MARK: Map response to json
extension ObservableType {
//    func mapProduct() -> Driver<SearchResult> {
//        return map { (response) in
//            let response = response as! Response
//            if response.statusCode == 200 {
//                return SearchResult.ok(repos: .SectionData(items: Repos(JSON(response.data)).repos))
//            } else {
//                return SearchResult.error(msg: "oops")
//            }
//            }.asDriver(onErrorJustReturn: SearchResult.error(msg: "oops"))
//    }
}
