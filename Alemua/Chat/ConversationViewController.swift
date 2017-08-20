//
//  ConversationViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AwesomeMVVM
import SwiftyJSON

struct ConversationModel {
    var name: String?
}

class ConversationViewController: BaseViewController {
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - General data
    var bag = DisposeBag()
    var datas = Variable<[ConversationUserData]>([])
    
    
    var refreshControl: UIRefreshControl!
    func refresh(_ sender: Any) {
        reloadPage()
        refreshControl.endRefreshing()
    }
    
    override func bindToViewModel() {
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView.register(UINib(nibName: "ConversationTableViewCell", bundle: nil), forCellReuseIdentifier: "ConversationTableViewCell")
        //create cell
        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: "ConversationTableViewCell")) {
            (row, item, cell) in
            (cell as! ConversationTableViewCell).bindData(data: item)
        }.addDisposableTo(bag)

        //Handle click
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
//            self.chatCoor.showChatScreen()
            //TODO: IF ORDER / DELIVERY
            HomeCoordinator.sharedInstance.showChatScreen(friend: self.datas.value[ip.row])
        }).addDisposableTo(bag)

        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
        //Fetch data
        fetchData()
    }
    override func responseFromViewModel() {
        // Simple view controller -> Don't need viewmodel
    }

    override func viewWillAppear(_ animated: Bool) {
        if !Prefs.isUserLogged {
            if LoginViewController.isIgnore {
                onBack("")
                LoginViewController.isIgnore = false
            }else{
                HomeCoordinator.sharedInstance.showLoginScreen()
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func reloadPage(){
        AlemuaApi.shared.aleApi.request(AleApi.getListUsersToChat())
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result):
                    if let result = result.array {
                        self.datas.value = result.map { ConversationUserData(json: $0) }
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }
    
    func fetchData(){
        AlemuaApi.shared.aleApi.request(AleApi.getListUsersToChat())
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result):
                    if let result = result.array {
                        self.datas.value = result.map { ConversationUserData(json: $0) }
                        self.datas.value.forEach({ (user) in
                            SocketIOHelper.shared.emitLoadMessage(receiveId: user.id!)
                        })
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }


    func fetchConversationList() -> Observable<[ConversationModel]> {

        //sample data
        return Observable.just((0..<20).map { ConversationModel(name: "\($0)") })
    }
    // MARK: - Action
    @IBAction func onBack(_ sender: Any) {
        if HomeViewController.homeType == .order {
            OrderNavTabBarViewController.sharedInstance.switchTab(index: 0)
        } else {
            DeliveryNavTabBarViewController.sharedInstance.switchTab(index: 0)
        }
    }
}
