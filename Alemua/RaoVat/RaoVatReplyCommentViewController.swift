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
import RxDataSources
import Toaster

class RaoVatReplyCommentViewController: BaseViewController {
    var bag = DisposeBag()
    var currentPage = 1
    var data: CommentResponse!
    var advDetail: ProductDetailResponse!
    var datas = Variable<[CommentResponse]>([])
    var reload = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tfContent: UITextField!
    
    var refreshControl: UIRefreshControl!
    func refresh(_ sender: Any) {
        reloadPage()
        refreshControl.endRefreshing()
    }
    
    override func bindToViewModel() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.register(nib: UINib(nibName: "CommentTableViewCell", bundle: nil), withCellClass: CommentTableViewCell.self)
        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: "CommentTableViewCell")) { (ip, item, cell) in
            (cell as CommentTableViewCell).bindData(data: item, advDetail: nil)
            }.addDisposableTo(bag)
        
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            //            RaoVatCoordinator.sharedInstance.showRaoVatS(data: self.datas.value[ip.row])
        }).addDisposableTo(bag)
        
        //Loadmore
        tableView.addInfiniteScroll { (tv) in
            // update table view
            // finish infinite scroll animation
            self.fetchComment()
            tv.finishInfiniteScroll()
        }
        
        tableView.beginInfiniteScroll(true)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
    }
    
    override func responseFromViewModel() {
        
    }
    
    func reloadPage(){
        currentPage = 1
        reload = true
        fetchComment()
    }
    func fetchComment(){
        
        datas.value = data.subComment ?? []
        
//        RaoVatService.shared.api.request(RaoVatApi.getAllComments(adv_detail_id: data.id!, page_number: currentPage))
//            .toJSON()
//            .subscribe(onNext: { (res) in
//                switch res {
//                case .done(let result, _):
//                    if self.reload {
//                        self.datas.value.removeAll()
//                        self.reload = false
//                    }
//                    self.currentPage += 1
//                    if let arr = result.array {
//                        self.datas.value.append(contentsOf: arr.map { CommentResponse(json: $0) }.filter {$0.commentId! > 0 })
//                    }
//                    break
//                case .error(let msg):
//                    print("Error \(msg)")
//                    break
//                }
//            }).addDisposableTo(bag)
        
    }
    
    
    @IBAction func onSendComment(_ sender: Any) {
        if let content = tfContent.text {
            RaoVatService.shared.api.request(RaoVatApi.addComment(adv_detail_id: advDetail.id!, comment_id: data.id!, content: content))
                .toJSON()
                .subscribe(onNext: { (res) in
                    switch res {
                    case .done(let result, _):
                        self.tfContent.text = ""
//                        self.reloadPage()
                        let c = CommentResponse()
                        c.timeAgo = 0
                        c.content = content
                        c.userPhoto = Prefs.photo
                        c.userId = Prefs.userId
                        c.userName = Prefs.userName
                        self.datas.value.append(c)
                        
                        RaoVatCommentViewController.shared.shouldReload = true
//                        RaoVatCoordinator.sharedInstance.navigation?.popViewController()
                        break
                    case .error(let msg):
                        Toast.init(text: msg).show()
                        print("Error \(msg)")
                        break
                    }
                }).addDisposableTo(bag)
            
        }
    }
    
}

