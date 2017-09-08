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
    public static var shared: NotifyViewController!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var notifyBar: UITabBarItem!
    var bag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!

    var datas = Variable<[NotifyData]>([])
    var currentPage = 1

    func refresh(_ sender: Any) {
        reloadPage()
        refreshControl.endRefreshing()
    }

    override func bindToViewModel() {
        NotifyViewController.shared = self
        refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        let nibName = "NotifyTableViewCell"
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)

        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: nibName)) { (row, item, cell) in
            // TODO: Bind data here
            (cell as! NotifyTableViewCell).bindData(data: item)
        }.addDisposableTo(bag)
        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            AlemuaApi.shared.aleApi.request(AleApi.readNotification(notification_id: self.datas.value[ip.row].id!))
                .toJSON()
                .subscribe(onNext: { (res) in
                    switch res {
                    case .done(let result):
                        self.datas.value[ip.row].isRead = 1
                        self.tableView.reloadData()
                        
                        if HomeViewController.homeType == .order {
                            OrderNavTabBarViewController.sharedInstance.fetchUnreadNoti()
                        }else{
                            DeliveryNavTabBarViewController.sharedInstance.fetchUnreadNoti()
                        }
                        break
                    case .error(let msg):
                        print("Error \(msg)")
                        break
                    }
                }).addDisposableTo(self.bag)

            switch self.datas.value[ip.row].notificationType! {
            case 1:
                OrderNavTabBarViewController.sharedInstance.switchTab(index: 1)
                OrderOrderViewController.selectViewController = 1
                break
            case 2:
                DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 1)
                DeliveryOrderViewController.defaultTab = 1
                break
            case 3:
                DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 1)
                DeliveryOrderViewController.defaultTab = 3
                break
            case 4:
                DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 1)
                DeliveryOrderViewController.defaultTab = 2
                break
            default:
                AccountCoordinator.sharedInstance.showNotifyThanhToan()
                break
            }


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
        let isShipper = HomeViewController.homeType == .order ? 0 : 1
        AlemuaApi.shared.aleApi.request(.getNotifications(page_number: currentPage, is_shipper: isShipper))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    if let arr = result.array {
                        self.datas.value = arr.map { NotifyData(json: $0) }
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }

    //Interact API
    func fetchData() {
        let isShipper = HomeViewController.homeType == .order ? 0 : HomeViewController.homeType == .delivery ? 1 : 2
        AlemuaApi.shared.aleApi.request(.getNotifications(page_number: currentPage, is_shipper: isShipper))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    if let arr = result.array {
                        self.datas.value.append(contentsOf: arr.map { NotifyData(json: $0) })
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)



    }
    @IBAction func onBack(_ sender: Any) {
        if HomeViewController.homeType == .order {
            OrderNavTabBarViewController.sharedInstance.switchTab(index: 0)
        } else if HomeViewController.homeType == .delivery {
            DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 0)
        } else {
            RaoVatCoordinator.sharedInstance.navigation?.popViewController()
        }
    }
}

