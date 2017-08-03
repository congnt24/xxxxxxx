//
//  DeliveryMain.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxCocoa
import RxSwift
import Moya
import SwiftyJSON

class DeliveryMainViewController: BaseViewController {
    let bag = DisposeBag()
    
    let AleProvider = RxMoyaProvider<AleApi>(endpointClosure: endpointClosure)
    @IBOutlet weak var tfLink: AwesomeTextField!
    
    @IBOutlet weak var tableView: UITableView!
    override func bindToViewModel() {
        let nibName = "DeliveryTableViewCell"
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)
        
        fetchData().asObservable().bind(to: tableView.rx.items(cellIdentifier: nibName)) { (row, item, cell) in
            
            (cell as! DeliveryTableViewCell).bindData(data: item)
            (cell as! DeliveryTableViewCell).onClickBaoGia = {
                DeliveryCoordinator.sharedInstance.showDeliveryDonHang()
            }
            // TODO: Bind data here
            }.addDisposableTo(bag)
        tableView.estimatedRowHeight = 96 // some constant value
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            DeliveryCoordinator.sharedInstance.showDeliveryDonHang()
        }).addDisposableTo(bag)
    }
    
    
    //Interact API
    func fetchData() -> Driver<[ModelQuoteData]> {
        return AleProvider.request(AleApi.getQuoteForShipper(UserID: "0", page_number: 1)).filterSuccessfulStatusCodes()
        .flatMap { (response) -> Observable<[ModelQuoteData]> in
            let obj = ModelQuoteResponse(json: JSON(response.data))
            return Observable.from(optional: obj.result)
        }.asDriver(onErrorJustReturn: [])
    }

}
