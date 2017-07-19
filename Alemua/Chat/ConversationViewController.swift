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
    var chatCoor: ChatCoordinator!
    var bag = DisposeBag()
    
    override func bindToViewModel() {
        //create cell
         fetchConversationList().bind(to: tableView.rx.items(cellIdentifier: "conversation_view_cell")){
            (row, element, cell) in
            cell.textLabel?.text = element.name
        }.addDisposableTo(bag)
        
        //Handle click
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            self.chatCoor.showChatScreen()
        }).addDisposableTo(bag)
        
        
    }
    override func responseFromViewModel() {
        // Simple view controller -> Don't need viewmodel
    }
    
    
    func fetchConversationList() -> Observable<[ConversationModel]>{
        
        //sample data
        return Observable.just((0..<20).map {ConversationModel(name: "\($0)")})
    }
    // MARK: - Action
}
