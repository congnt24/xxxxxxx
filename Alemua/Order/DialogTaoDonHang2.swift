//
//  DialogTaoDonHang2.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/24/17.
//  Copyright © 2017 cong. All rights reserved.
//


import Foundation
import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa
import SwiftyJSON
import Kingfisher

class DialogTaoDonHang2: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let bag = DisposeBag()
    var datas = Variable<[CurrencyData]>([])
    override func viewDidLoad() {
        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: "CurrencyTableViewCell")) { (ip, item, cell) in
            (cell as! CurrencyTableViewCell).bindData(data: item)
        }.addDisposableTo(bag)
        
        tableView.rx.itemSelected.subscribe { ip in
            DialogTaoDonHang.shared.data = self.datas.value[(ip.element?.row)!]
            self.dismiss(animated: true, completion: nil)
        }.addDisposableTo(bag)
        
        fetchData()
    }
    
    
    func fetchData() {
        AlemuaApi.shared.aleApi.request(AleApi.getAllCurrency())
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    if let res = result.array {
                        self.datas.value = res.map { CurrencyData(json: $0) }
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }
}

class CurrencyTableViewCell: UITableViewCell {
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var exchange: UILabel!
    
    func bindData(data: CurrencyData) {
        type.text = data.name
        exchange.text = data.conversion
        if let photo = data.photo {
            flag.kf.setImage(with: URL(string: photo))
        }
    }
    
}
