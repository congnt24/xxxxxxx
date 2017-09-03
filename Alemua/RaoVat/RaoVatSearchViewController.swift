//
//  RaoVatSearchViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 9/3/17.
//  Copyright © 2017 cong. All rights reserved.
//


import Foundation
import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

class RaoVatSearchViewController: BaseViewController {
    var searchRepo = SearchHistoryRepo()

    @IBOutlet weak var tfSearch: AwesomeTextField2!
    @IBOutlet weak var tableView: UITableView!
    var datas = Variable<[SearchHistory]>([])
    let bag = DisposeBag()

    override func bindToViewModel() {
        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: "basic")) { (i, item, cell) in
            cell.textLabel?.text = item.searchText
        }.addDisposableTo(bag)
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            //            RaoVatCoordinator.sharedInstance.showRaoVatDetail(data: self.datas.value[ip.row])
            RaoVatCategoryViewController.shared.onSearch(text: self.datas.value[ip.row].searchText)
            RaoVatCoordinator.sharedInstance.navigation?.popViewController()
        }).addDisposableTo(bag)
        
        //handle input link
        tfSearch.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { () in
            //open new screen
            self.addSearch(str: self.tfSearch.text)
            
            RaoVatCategoryViewController.shared.onSearch(text: self.tfSearch.text)
            RaoVatCoordinator.sharedInstance.navigation?.popViewController()
        }).addDisposableTo(bag)
        
        datas.value = searchRepo.getAll().toArray() as! [SearchHistory]
        
        
    }


    public func addSearch(str: String?) {
        let x = SearchHistory()
        x.searchText = str
        searchRepo.add(x)
    }

}


class SearchHistory: Object {
    dynamic var searchText: String?
}

class SearchHistoryRepo: Repository<SearchHistory> {

}
