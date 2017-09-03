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

class RaoVatViewController: BaseViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    var bag = DisposeBag()
    var datas = Variable<[AdvCategoryResponse]>([])
    let itemsPerRow: CGFloat = 2
    
    public static var shared: RaoVatViewController!
    
    override func bindToViewModel() {
        RaoVatViewController.shared = self
        collectionView.delegate = self
        datas.asObservable().bind(to: collectionView.rx.items(cellIdentifier: "RaoVatViewCell")) { (ip, item, cell) in
            (cell as RaoVatViewCell).bindData(data: item)
        }.addDisposableTo(bag)
        
        collectionView.rx.itemSelected.subscribe(onNext: { (ip) in
            RaoVatCoordinator.sharedInstance.showRaoVatCategory(data: self.datas.value[ip.row])
        }).addDisposableTo(bag)
        fetchData()
    }
    
    override func responseFromViewModel() {
        
    }
    @IBAction func onNotify(_ sender: Any) {
    }
    @IBAction func onDangTin(_ sender: Any) {
        RaoVatCoordinator.sharedInstance.showRaoVatPublish(data: "")
    }
    
    @IBAction func onMenu(_ sender: Any) {
        RaoVatCoordinator.sharedInstance.showRaoVatMenu(data: "")
    }
    
    
    func fetchData(){
        
        RaoVatService.shared.api.request(RaoVatApi.getAllAdvCategory())
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    if let arrs = result.array {
                        self.datas.value = arrs.map { AdvCategoryResponse(json: $0) }
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = 10 * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 0.7)
    }
    
}


class RaoVatViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        
    }
    
    func bindData(data: AdvCategoryResponse){
        title.text = data.name
        if let p = data.photo {
            photo.kf.setImage(with: URL(string: p), placeholder: UIImage(named: "no_image"))
        }
    }
}

