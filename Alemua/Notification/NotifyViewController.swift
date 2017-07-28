//
//  NotifyViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class NotifyViewController: BaseViewController {
    @IBOutlet weak var containerView: UIView!
    var bag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    override func bindToViewModel() {
        let nibName = "NotifyTableViewCell"
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)
        
        fetchData().bind(to: tableView.rx.items(cellIdentifier: nibName)) { (row, item, cell) in
            // TODO: Bind data here
            }.addDisposableTo(bag)
        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            AccountCoordinator.sharedInstance.showNotifyThanhToan()
        }).addDisposableTo(bag)

    }
    
    override func responseFromViewModel() {
        
    }
    
    //Interact API
    func fetchData() -> Observable<[String]> {
        return Observable.just((0..<20).map { "\($0)" })
    }
}

