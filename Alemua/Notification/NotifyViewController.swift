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
    var refreshControl: UIRefreshControl!

    var datas = Variable<[String]>([])

    func refresh(_ sender: Any) {
        reloadPage()
        refreshControl.endRefreshing()
    }

    override func bindToViewModel() {

        refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)

        let nibName = "NotifyTableViewCell"
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)

        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: nibName)) { (row, item, cell) in
            // TODO: Bind data here
        }.addDisposableTo(bag)
        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            AccountCoordinator.sharedInstance.showNotifyThanhToan()
        }).addDisposableTo(bag)
        fetchData()
    }

    override func responseFromViewModel() {

    }

    override func viewWillAppear(_ animated: Bool) {
        if !Prefs.isUserLogged {
            if LoginViewController.isIgnore {
                onBack("")
                LoginViewController.isIgnore = false
            } else {
                HomeCoordinator.sharedInstance.showLoginScreen()
            }
            return
        }

    }

    override func viewWillDisappear(_ animated: Bool) {

    }

    func reloadPage() {
        fetchData()
    }

    //Interact API
    func fetchData() {
        datas.value = (0..<20).map { "\($0)" }
    }
    @IBAction func onBack(_ sender: Any) {
        if HomeViewController.homeType == .order {
            OrderNavTabBarViewController.sharedInstance.switchTab(index: 0)
        } else {
            DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 0)
        }
    }
}

