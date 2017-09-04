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
import Kingfisher

class RaoVatCategoryViewController: BaseViewController {
    public static var shared: RaoVatCategoryViewController!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    var bag = DisposeBag()
    var currentPage = 1
    var datas = Variable<[ProductResponse]>([])
    var data: AdvCategoryResponse!
    var filterRequest: FilterRequest?

    var reload = false
    var textSearch: String?


    var refreshControl: UIRefreshControl!
    override func bindToViewModel() {
        RaoVatCategoryViewController.shared = self
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)

        initData()
        navBar.title = data.name
    }

    func refresh(_ sender: Any) {
        reloadPage()
        refreshControl.endRefreshing()
    }
    override func responseFromViewModel() {

    }

    override func viewWillAppear(_ animated: Bool) {
        if (filterRequest != nil) {
            refresh("")
        }
    }


    func initData() {
        tableView.register(nib: UINib(nibName: "RaoVatCategoryTableViewCell", bundle: nil), withCellClass: RaoVatCategoryTableViewCell.self)
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
    
    func onSearch(text: String?){
        LoadingOverlay.shared.showOverlay(view: view)
        textSearch = text
        reload = true
        currentPage = 1
        fetchData()
    }

    func reloadPage() {
        textSearch = nil
        reload = true
        currentPage = 1
        fetchData()
    }


    //Interact API
    func fetchData() {
        if let data = filterRequest {
            let location = RaoVatViewController.shared.curLocation
            let lat = Float(location?.coordinate.latitude ?? 0)
            let lon = Float(location?.coordinate.longitude ?? 0)
            RaoVatService.shared.api.request(RaoVatApi.filterAdv(filterRequest: data, lat: lat, lon: lon, page_number: currentPage))
                .toJSON()
                .subscribe(onNext: { (res) in
                    switch res {
                    case .done(let result, _):
                        if self.reload {
                            self.reload = false
                            self.datas.value.removeAll()
                        }
                        LoadingOverlay.shared.hideOverlayView()
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
        } else {
            RaoVatService.shared.api.request(RaoVatApi.getAllAdv(adv_type: 1, category_id: data.id!, latitude: 0, longitude: 0, page_number: currentPage, text_search: self.textSearch))
                .toJSON()
                .subscribe(onNext: { (res) in
                    switch res {
                    case .done(let result, _):
                        if self.reload {
                            self.reload = false
                            self.datas.value.removeAll()
                        }
                        LoadingOverlay.shared.hideOverlayView()
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


    }

    @IBAction func onFilter(_ sender: Any) {
        RaoVatCoordinator.sharedInstance.showRaoVatFilter(data: data)
    }

    @IBAction func onDangTin(_ sender: Any) {
        RaoVatCoordinator.sharedInstance.showRaoVatPublish(data: "")
    }
    @IBAction func onSearch(_ sender: Any) {
        RaoVatCoordinator.sharedInstance.showSearchViewController()
    }
}



class RaoVatCategoryTableViewCell: SwipeTableViewCell {
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

    func bindData(data: ProductResponse) {
        if let p = data.photo, p != "" {
            let arr = p.splitted(by: ",")
            photo.kf.setImage(with: URL(string: arr[0]), placeholder: UIImage(named: "no_image"))
        }
        if let pro = data.promotion, pro > 0 {
            discount.isHidden = false
            oldPrice.isHidden = false
            discount.setTitle("\(pro)%", for: .normal)
        } else {
            discount.isHidden = true
            oldPrice.isHidden = true
        }
        name.text = data.title
        distance.text = "\((data.distance ?? 0).toDistanceFormated())"
        if data.productType! == 1 {
            newItem.text = "Hàng mới"
        } else if data.productType! == 2 {
            newItem.text = "Hàng sang tay"
        } else {
            newItem.text = "Đã qua sử dụng"
        }
        oldPrice.setText(str: "\(data.price!)".toFormatedPrice())
        newPrice.text = "\(data.price! * (100 - (data.promotion ?? 0)) / 100)".toFormatedPrice()
        views.text = "\(data.numberViewed ?? 0)"
        duration.text = data.endDate?.toDate()?.toFormatedDuration()
    }
}

