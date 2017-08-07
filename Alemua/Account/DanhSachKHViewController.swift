//
//  DanhSachKHViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/5/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON

class DanhSachKHViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var datas = Variable<[ClientResponse]>([])
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        tableView.register(UINib(nibName: "KhachHangTableViewCell", bundle: nil), forCellReuseIdentifier: "KhachHangTableViewCell")
        //Configure cell
        AlemuaApi.shared.aleApi.request(.getListClients())
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result):
                    self.datas.value = result.array!
                        .map { ClientResponse(json: $0) }
                    print("Cancel success")
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                default: break
                }
            }).addDisposableTo(bag)
        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: "KhachHangTableViewCell")){ (row, item, cell) in
            (cell as! KhachHangTableViewCell).bindData(data: item)
            }.addDisposableTo(bag)

    }

}
