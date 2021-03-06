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

struct ConversationModel {
    var name: String?
}

class ConversationViewController: BaseViewController {
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - General data
    var bag = DisposeBag()

    override func bindToViewModel() {
        tableView.register(UINib(nibName: "ConversationTableViewCell", bundle: nil), forCellReuseIdentifier: "ConversationTableViewCell")
        //create cell
        fetchConversationList().bind(to: tableView.rx.items(cellIdentifier: "ConversationTableViewCell")) {
            (row, element, cell) in
            
        }.addDisposableTo(bag)

        //Handle click
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
//            self.chatCoor.showChatScreen()
            //TODO: IF ORDER / DELIVERY
            HomeCoordinator.sharedInstance.showChatScreen()
        }).addDisposableTo(bag)

        
        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    override func responseFromViewModel() {
        // Simple view controller -> Don't need viewmodel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //TODO: Check if user is logged
        if !Prefs.isUserLogged {
            HomeCoordinator.sharedInstance.showLoginScreen()
            return
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }


    func fetchConversationList() -> Observable<[ConversationModel]> {

        //sample data
        return Observable.just((0..<20).map { ConversationModel(name: "\($0)") })
    }
    // MARK: - Action
}
