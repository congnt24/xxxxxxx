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
import Toaster


enum ActionType: Int {
    case Favorite = 2
    case Published = 3
}
class RaoVatProfileListActionViewController: BaseViewController, SwipeTableViewCellDelegate {
    var bag = DisposeBag()
    var currentPage = 1
    var datas = Variable<[ProductResponse]>([])
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
            RaoVatService.shared.api.request(RaoVatApi.deleteAdv(adv_detail_id: self.datas.value[indexPath.row].id!))
                .toJSON()
                .subscribe(onNext: { (res) in
                    switch res {
                    case .done(let result, let msg):
                        Toast.init(text: msg).show()
                        self.datas.value.remove(at: indexPath.row)
                        break
                    case .error(let msg):
                        Toast.init(text: msg).show()
                        print("Error \(msg)")
                        break
                    }
                }).addDisposableTo(self.bag)

        }
        // customize the action appearance
        deleteAction.backgroundColor = UIColor(hexString: "#F16745")!
        deleteAction.image = UIImage(named: "ic_trash")
        let editAction = SwipeAction(style: .default, title: "SỬA") { action, indexPath in
            // handle action by updating model with edition
            RaoVatCoordinator.sharedInstance.showRaoVatPublishForEdit(data: self.datas.value[indexPath.row])
            
        }
        // customize the action appearance
        editAction.backgroundColor = UIColor(hexString: "#4CC3D9")!
        editAction.image = UIImage(named: "ic_trash")

        return [editAction, deleteAction]
    }


    func initData() {
        
        tableView.register(nib: UINib(nibName: "RaoVatCategoryTableViewCell", bundle: nil), withCellClass: RaoVatCategoryTableViewCell.self)
        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: "RaoVatCategoryTableViewCell")) { (ip, item, cell) in
            (cell as! RaoVatCategoryTableViewCell).bindData(data: item)
            if self.actionType == .Published {
                (cell as! RaoVatCategoryTableViewCell).delegate = self
            }
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

    func reloadPage() {
        currentPage = 1
        datas.value.removeAll()
        fetchData()
    }


    //Interact API
    func fetchData() {
        //2 = yeu thichs, 3 = da dang
        RaoVatService.shared.api.request(RaoVatApi.getAllAdv(adv_type: actionType.rawValue, category_id: nil, latitude: 0, longitude: 0, page_number: currentPage, text_search: nil))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    if let arr = result.array {
                        self.datas.value.append(contentsOf: arr.map { ProductResponse(json: $0) })
                    }
                    self.currentPage += 1
                    break
                case .error(let msg):
                    Toast.init(text: msg).show()
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)


    }


    @IBAction func onSearch(_ sender: Any) {
    }
}

