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
import Moya
import SwiftyJSON

class OrderMain1ViewController: BaseViewController, UITableViewDelegate {

    @IBOutlet weak var input: AwesomeTextField2!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let bag = DisposeBag()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfOrder>()

    let aleApi = RxMoyaProvider<AleApi>(endpointClosure: endpointClosure)

    override func bindToViewModel() {
        tableView.delegate = self
        let nibName = "OrderViewCell"
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)
        let headerNib = UINib(nibName: "OrderMainHeaderTableViewCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: "OrderMainHeaderTableViewCell")
        tableView.register(UINib(nibName: "OrderMainOnlineTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderMainOnlineTableViewCell")

        //handle input link
        input.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { () in
            //open new screen
            OrderCoordinator.sharedInstance.showTaoDonHang(text: self.input.text)

        }).addDisposableTo(bag)
        input.rx.text.subscribe(onNext: { (text) in
            if text == "" {
                self.btnClear.isHidden = true
            } else {
                self.btnClear.isHidden = false

            }
        }).addDisposableTo(bag)

        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = 96
        configureDataSource()
    }


    func configureDataSource() {
        dataSource.configureCell = { ds, tv, ip, model in
            let section = ds.sectionModels[ip.section]
            switch section {
            case .Order:
                let cell = tv.dequeueReusableCell(withIdentifier: "OrderViewCell") as! OrderViewCell
                cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onSelectItem)))
                (cell).bindData(item: model as! ModelOrderData)
                return cell
            case .Online:
                let cell = tv.dequeueReusableCell(withIdentifier: "OrderMainOnlineTableViewCell") as! OrderMainOnlineTableViewCell
                cell.bindData(data: model as! ModelBuyingOnline)
                return cell
            }
        }
        dataSource.canEditRowAtIndexPath = { (ds, ip) in
            return false
        }
        
        fetchData().asObservable().bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(bag)

        //delegate
    }

    func onSelectItem() {
        OrderCoordinator.sharedInstance.showTaoDonHang()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderMainHeaderTableViewCell") as! OrderMainHeaderTableViewCell
        switch section {
        case 0:
            cell.xemthem.isHidden = true
            cell.title.text = "Mua hàng Online"
            break
        case 1:
            cell.xemthem.isHidden = false
            cell.title.text = "Sản phẩm Hot"
            break
        default:
            cell.xemthem.isHidden = false
            cell.title.text = "Sản phẩm đang giảm giá"
            break
        }
        cell.onXemThemDelegate = {
            print("Header clicked")
            OrderCoordinator.sharedInstance.showSanPhamHot(section: cell.title.text!)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }

    @IBAction func onClear(_ sender: Any) {
        input.text = ""
        btnClear.isHidden = true
    }
    @IBAction func onNotifyClick(_ sender: Any) {

    }

}


extension OrderMain1ViewController {
    //Interact API
    func fetchData() -> Driver<[SectionOfOrder]> {
        return aleApi.request(AleApi.getHomeItems()).filterSuccessfulStatusCodes()
            .flatMap { (response) -> Observable<[SectionOfOrder]> in
            let json = JSON(response.data)
            let responseObj = ModelMainHomeResponse(json: json)
                let x = ModelBuyingOnline(items: responseObj.result?.buyingOnlineItem)
            let array = [
                SectionOfOrder.Online(datas: x),
                SectionOfOrder.Order(datas: (responseObj.result?.hotProducts)!),
                SectionOfOrder.Order(datas: (responseObj.result?.discountProducts)!)]
            return Observable.from(optional: array)
        }.asDriver(onErrorJustReturn: [])
    }

}

enum SectionOfOrder {
    case Order(datas: [ModelOrderData])
    case Online(datas: ModelBuyingOnline)
}

struct OrderData {
    var test: String
}

//struct SectionOfOrder {
//    var header: String
//    var items: [Item]
//}

extension SectionOfOrder: SectionModelType {
    typealias Item = Any
    var items: [Any] {
        switch self {
        case let .Order(datas: items):
            return items
        case let .Online(datas: items):
            return [items]
        default:
            return [""]
        }
    }

    init(original: SectionOfOrder, items: [Item]) {
        self = original
    }
}
