//
//  DeliveryIncomeViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 9/20/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa
import SwiftyJSON

class DeliveryIncomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let bag = DisposeBag()
    var datas = [IncomeData]()
    
    
    
    override func bindToViewModel() {
        tableView.dataSource = self
        tableView.delegate = self
        fetchData()
        
        tableView.estimatedRowHeight = 44 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeTableViewCell", for: indexPath) as! IncomeTableViewCell
        cell.bindData(data: datas[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "header")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func fetchData(){
        LoadingOverlay.shared.showOverlay(view: view)
        AlemuaApi.shared.aleApi.request(AleApi.getAllMoney())
            .toJSON()
            .subscribe(onNext: { (res) in
                LoadingOverlay.shared.hideOverlayView()
                switch res {
                case .done(let result, _):
                    print("get all money success")
                    if let arr = result.array {
                        self.datas = arr.map { IncomeData(json: $0) }
                        self.tableView.reloadData()
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }
}


class IncomeData {
    private struct SerializationKeys {
        static let orderId = "order_id"
        static let promotionMoney = "promotion_money"
        static let totalMoney = "total_money"
        static let sTT = "STT"
        static let totalPrice = "total_price"
    }
    
    public var orderId: String?
    public var promotionMoney: Int?
    public var totalMoney: Int?
    public var sTT: Int?
    public var totalPrice: Int?
    
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    public required init(json: JSON) {
        orderId = json[SerializationKeys.orderId].string
        promotionMoney = json[SerializationKeys.promotionMoney].int
        totalMoney = json[SerializationKeys.totalMoney].int
        sTT = json[SerializationKeys.sTT].int
        totalPrice = json[SerializationKeys.totalPrice].int
    }
}

class IncomeTableViewCell: UITableViewCell {
    @IBOutlet weak var lbSTT: UILabel!
    @IBOutlet weak var lbID: UILabel!
    @IBOutlet weak var lbPromo: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbMoney: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func bindData(data: IncomeData){
        lbSTT.text = "\(data.sTT ?? 0)"
        lbID.text = "\(data.orderId ?? "#0")"
        lbPromo.text = "\(data.promotionMoney ?? 0)"
        lbPrice.text = "\(data.totalPrice ?? 0)"
        lbMoney.text = "\(data.totalMoney ?? 0)"
    }
}
