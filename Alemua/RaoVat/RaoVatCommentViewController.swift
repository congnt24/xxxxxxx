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
import Kingfisher
import Toaster

class RaoVatCommentViewController: BaseViewController {
    public static var shared: RaoVatCommentViewController!
    var bag = DisposeBag()
    var currentPage = 1
    var data: ProductDetailResponse!
    var datas = Variable<[CommentResponse]>([])
    var reload = false
    @IBOutlet weak var tfContent: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    func refresh(_ sender: Any) {
        reloadPage()
        refreshControl.endRefreshing()
    }
    
    var shouldReload = false
    
    override func bindToViewModel() {
        RaoVatCommentViewController.shared = self
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.register(nib: UINib(nibName: "CommentTableViewCell", bundle: nil), withCellClass: CommentTableViewCell.self)
        tableView.register(nib: UINib(nibName: "ReplyCommentTableViewCell", bundle: nil), withCellClass: ReplyCommentTableViewCell.self)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, CommentResponse>>()
        dataSource.configureCell = { ds, tv, ip, model in
            if model.commentId  == 0 {
                let cell = tv.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
                cell.bindData(data: model, advDetail: self.data)
                return cell
            }else{
                let cell = tv.dequeueReusableCell(withIdentifier: "ReplyCommentTableViewCell") as! ReplyCommentTableViewCell
                cell.bindData(data: model)
                return cell
            }
        }

        
        datas.asObservable().flatMap({
            Observable.just([SectionModel(model: "", items: $0)])
        }).bind(to: tableView.rx.items(dataSource: dataSource)).addDisposableTo(bag)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
        
//        datas.asObservable().bind(to: tableView.rx.items(cellIdentifier: "CommentTableViewCell")) { (ip, item, cell) in
//            (cell as CommentTableViewCell).bindData(data: item)
//            }.addDisposableTo(bag)
        
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
        }).addDisposableTo(bag)
        
        //Loadmore
        tableView.addInfiniteScroll { (tv) in
            // update table view
            // finish infinite scroll animation
            self.fetchComment()
            tv.finishInfiniteScroll()
        }
        
        tableView.beginInfiniteScroll(true)
    }
    
    override func responseFromViewModel() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if shouldReload {
            
            reloadPage()
            shouldReload = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !Prefs.isUserLogged {
            if LoginViewController.isIgnore {
                LoginViewController.isIgnore = false
                RaoVatCoordinator.sharedInstance.navigation?.popViewController()
            }else{
                HomeCoordinator.sharedInstance.showLoginScreen()
            }
            return
        }
    }
    
    func reloadPage(){
        currentPage = 1
        reload = true
        fetchComment()
    }
    func fetchComment(){
        RaoVatService.shared.api.request(RaoVatApi.getAllComments(adv_detail_id: data.id!, page_number: currentPage))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    
                    if self.reload {
                        self.datas.value.removeAll()
                        self.reload = false
                    }
                    self.currentPage += 1
                    if let arr = result.array {
                        let arrComment = arr.map { CommentResponse(json: $0) }
                        var listComment = [CommentResponse]()
                        for item in arrComment {
                            listComment.append(item)
                            listComment.append(contentsOf: item.subComment ?? [])
                        }
                        self.datas.value.append(contentsOf: listComment)
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }
    
    
    @IBAction func onSendComment(_ sender: Any) {
        if let content = tfContent.text, content != "" {
            self.tfContent.text = ""
            RaoVatService.shared.api.request(RaoVatApi.addComment(adv_detail_id: data.id!, comment_id: 0, content: content))
                .toJSON()
                .subscribe(onNext: { (res) in
                    switch res {
                    case .done(let result, _):
                        self.reloadPage()
                        break
                    case .error(let msg):
                        Toast.init(text: msg).show()
                        print("Error \(msg)")
                        break
                    }
                }).addDisposableTo(bag)

        }else{
            
        }
    }
}


class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var btnReply: UIButton!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbComment: UILabel!
    @IBOutlet weak var lbTimeAgo: UILabel!
    var data: CommentResponse!
    var advDetail: ProductDetailResponse?
    func bindData(data: CommentResponse, advDetail: ProductDetailResponse?){
        self.data = data
        self.advDetail = advDetail
        if let p = data.userPhoto {
            photo.kf.setImage(with: URL(string: p))
        }
        lbName.text = data.userName
        lbComment.text = data.content
        lbTimeAgo.text = data.timeAgo?.toFormatedRaoVatTime()
        if advDetail == nil {
            btnReply.isHidden = true
        }
    }
    @IBAction func onReply(_ sender: Any) {
        
        RaoVatCoordinator.sharedInstance.showRaoVatReplyComment(data: data, advDetail: advDetail!)
    }
}


class ReplyCommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbComment: UILabel!
    @IBOutlet weak var lbTimeAgo: UILabel!
    func bindData(data: CommentResponse){
        if let p = data.userPhoto {
            photo.kf.setImage(with: URL(string: p), placeholder: UIImage(named: "no_image"))
        }
        lbName.text = data.userName
        lbComment.text = data.content
        lbTimeAgo.text = data.timeAgo?.toFormatedRaoVatTime()
        
    }
}

