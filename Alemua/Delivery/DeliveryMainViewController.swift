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

class DeliveryMainViewController: BaseViewController {
    let bag = DisposeBag()
    
    @IBOutlet weak var tfLink: AwesomeTextField!
    
    @IBOutlet weak var tableView: UITableView!
    override func bindToViewModel() {
        let nibName = "DeliveryTableViewCell"
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)
        
        fetchData().bind(to: tableView.rx.items(cellIdentifier: nibName)) { (row, item, cell) in
            (cell as! DeliveryTableViewCell).onClickBaoGia = {
                DeliveryCoordinator.sharedInstance.showDeliveryDonHang()
            }
            // TODO: Bind data here
            }.addDisposableTo(bag)
        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            DeliveryCoordinator.sharedInstance.showDeliveryDonHang()
        }).addDisposableTo(bag)
    }
    
    
    //Interact API
    func fetchData() -> Observable<[String]> {
        return Observable.just((0..<20).map { "\($0)" })
    }

}
