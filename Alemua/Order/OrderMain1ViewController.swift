//
//  OrderMain1ViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import AwesomeMVVM

class OrderMain1ViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    let bag = DisposeBag()

    override func bindToViewModel() {
        let nibName = "DonHangTableViewCell"
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)
        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            OrderCoordinator.sharedInstance.showTaoDonHang()
        }).addDisposableTo(bag)
        configureDataSource()
    }

    func configureDataSource() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfOrder>()
        dataSource.configureCell = { ds, tv, ip, model in
            
            
            let cell = tv.dequeueReusableCell(withIdentifier: "DonHangTableViewCell") as! DonHangTableViewCell

            return cell
        }
        dataSource.canEditRowAtIndexPath = { (ds, ip) in
            return false
        }
        dataSource.titleForHeaderInSection = { ds, sectionIndex in
            return ds[sectionIndex].header
        }
        
        Observable.from([onlineData(), hotData(), giamgiaData()]).bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(bag)
        
        
//        fetchData().flatMap({ // (todo) -> Observable<[SectionModel<String, [TodoModel]>]> in
//            Observable.just([SectionOfOrder(header: "Hot", items: $0)])
//        }).bind(to: tableView.rx.items(dataSource: dataSource))
//            .addDisposableTo(bag)
    }

}

//Interact API
func fetchData() -> Observable<[OrderData]> {
    return Observable.just((0..<20).map { OrderData(test: "\($0)") })
}

func onlineData() -> SectionOfOrder {
    return SectionOfOrder(header: "Mua hàng Online", items: [OrderData(test: "1")])
}
func hotData() -> SectionOfOrder {
    return SectionOfOrder(header: "Sản phẩm Hot", items: [OrderData(test: "1"), OrderData(test: "1")])
}
func giamgiaData() -> SectionOfOrder {
    return SectionOfOrder(header: "Sản phẩm đang giảm giá", items: [OrderData(test: "1"), OrderData(test: "2")])
}



struct OrderData {
    var test: String
}

struct SectionOfOrder {
    var header: String
    var items: [Item]
}

extension SectionOfOrder: SectionModelType {
    typealias Item = OrderData
    init(original: SectionOfOrder, items: [Item]) {
        self = original
        self.items = items
    }
}
