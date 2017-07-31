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
    var dataSource = RxTableViewSectionedReloadDataSource<SectionOfProduct>()
    
    
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
        //Configure cell
        
        dataSource.configureCell = { ds, tv, ip, model in
            if ds[ip.section].header == "load" { //handle load more
                let cell = tv.dequeueReusableCell(withIdentifier: "DonHangTableViewCell") as! DonHangTableViewCell
                
                return cell
            }else{ //handle regular cell
                let cell = tv.dequeueReusableCell(withIdentifier: "DonHangTableViewCell") as! DonHangTableViewCell
                
                return cell
            }
        }
//        tableView.addInfiniteScroll { (tv) in
//            // update table view
//            self.fetchData()
//            // finish infinite scroll animation
//            tv.finishInfiniteScroll()
//        }
//        
//        tableView.beginInfiniteScroll(true)
    }
    
    func fetchData(){ // fetch data and map to ProductData
        aleApi.request(.getProducts(type: section.rawValue, page: currentPage)).filterSuccessfulStatusCodes().flatMap { (response) in
            return Observable.just(JSON(data: response.data))
        }
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





// MARK : DEFINE MODEL HERE

struct ProductData {
    var test: String
}

struct SectionOfProduct {
    var header: String
    var items: [Item]
}

extension SectionOfProduct: SectionModelType {
    typealias Item = ProductData
    init(original: SectionOfProduct, items: [Item]) {
        self = original
        self.items = items
    }
}

