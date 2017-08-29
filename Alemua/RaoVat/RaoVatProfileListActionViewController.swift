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
import SwipeCellKit


enum ActionType: Int {
    case Favorite = 0
    case Published = 1
}
class RaoVatProfileListActionViewController: BaseViewController, SwipeTableViewCellDelegate {
    var bag = DisposeBag()
    var currentPage = 1
    var datas = Variable<[String]>([])
    var actionType = ActionType.Favorite
    
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBOutlet weak var tableView: UITableView!
    override func bindToViewModel() {
        switch actionType {
        case .Favorite:
            navTitle.title = "Sản phẩm yêu thích"
            break
        default:
            navTitle.title = "Sản phẩm đã đăng"
            break
        }
        initData()
    }
    
    override func responseFromViewModel() {
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "XÓA") { action, indexPath in
            // handle action by updating model with deletion
            
        }
        // customize the action appearance
        deleteAction.backgroundColor = UIColor(hexString: "#F16745")!
        deleteAction.image = UIImage(named: "ic_trash")
        let editAction = SwipeAction(style: .default, title: "SỬA") { action, indexPath in
            // handle action by updating model with edition
        }
        // customize the action appearance
        editAction.backgroundColor = UIColor(hexString: "#4CC3D9")!
        editAction.image = UIImage(named: "ic_trash")
        
        return [editAction, deleteAction]
    }
    
    
    func initData(){
        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: "RaoVatCategoryTableViewCell")) { (ip, item, cell) in
            (cell as! RaoVatCategoryTableViewCell).bindData(data: item)
            
            (cell as! RaoVatCategoryTableViewCell).delegate = self
            }.addDisposableTo(bag)
        
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
//            RaoVatCoordinator.sharedInstance.showRaoVatDetail(data: self.datas.value[ip.row])
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
    
    
    @IBAction func onSearch(_ sender: Any) {
    }
}

