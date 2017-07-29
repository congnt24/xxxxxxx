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

class OrderMain1ViewController: BaseViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let bag = DisposeBag()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfOrder>()

    override func bindToViewModel() {
        tableView.delegate = self
        let nibName = "DonHangTableViewCell"
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)
        let headerNib = UINib(nibName: "OrderMainHeaderTableViewCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: "OrderMainHeaderTableViewCell")
        tableView.register(UINib(nibName: "OrderMainOnlineTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderMainOnlineTableViewCell")
        
        
        
        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
        configureDataSource()
    }

    func configureDataSource() {
        dataSource.configureCell = { ds, tv, ip, model in
            if ip.section == 0 {
                let cell = tv.dequeueReusableCell(withIdentifier: "OrderMainOnlineTableViewCell") as! OrderMainOnlineTableViewCell
                
                return cell
            }else{
                let cell = tv.dequeueReusableCell(withIdentifier: "DonHangTableViewCell") as! DonHangTableViewCell
                
                cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onSelectItem)))
                
                return cell
            }
        }
        dataSource.canEditRowAtIndexPath = { (ds, ip) in
            return false
        }
        dataSource.titleForHeaderInSection = { ds, sectionIndex in
            return ds[sectionIndex].header
        }

        Observable.from([onlineData(), hotData(), giamgiaData()]).bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(bag)

        //delegate
    }
    
    func onSelectItem(){
        OrderCoordinator.sharedInstance.showTaoDonHang()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderMainHeaderTableViewCell") as! OrderMainHeaderTableViewCell
        switch section {
        case 0:
            cell.xemthem.isHidden = true
            break
        default:
            cell.xemthem.isHidden = false
            break
        }
        cell.title.text = dataSource[section].header
        cell.onXemThemDelegate = {
            print("Header clicked")
            OrderCoordinator.sharedInstance.showSanPhamHot()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
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
