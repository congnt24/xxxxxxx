//
//  BaoGiaViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class RaoVatCategoryViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    var bag = DisposeBag()
    var currentPage = 1
    var datas = Variable<[String]>([])
    
    
    var refreshControl: UIRefreshControl!
    override func bindToViewModel() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        initData()
    }
    
    func refresh(_ sender: Any) {
        reloadPage()
        refreshControl.endRefreshing()
    }
    override func responseFromViewModel() {
        
    }
    
    
    func initData(){
        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: "RaoVatCategoryTableViewCell")) { (ip, item, cell) in
            (cell as RaoVatCategoryTableViewCell).bindData(data: item)
            }.addDisposableTo(bag)
        
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            RaoVatCoordinator.sharedInstance.showRaoVatDetail(data: self.datas.value[ip.row])
        }).addDisposableTo(bag)
        
        //Loadmore
        tableView.addInfiniteScroll { (tv) in
            // update table view
            // finish infinite scroll animation
            self.fetchData()
            tv.finishInfiniteScroll()
        }
        
        tableView.beginInfiniteScroll(true)
    }
    
    func reloadPage(){
        currentPage = 1
        datas.value = (0...10).map {"\($0)"}
    }
    
    
    //Interact API
    func fetchData() {
        datas.value.append(contentsOf: (0...10).map {"\($0)"})
        currentPage+=1
    }

    @IBAction func onFilter(_ sender: Any) {
    }
    
    @IBAction func onDangTin(_ sender: Any) {
        RaoVatCoordinator.sharedInstance.showRaoVatPublish(data: "")
    }
}



class RaoVatCategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var discount: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var newItem: UILabel!
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var oldPrice: StrikeThroughLabel!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    func bindData(data: Any) {
        
    }
}

