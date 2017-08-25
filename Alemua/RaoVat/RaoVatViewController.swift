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
    var datas = Variable<[String]>([])
    let itemsPerRow: CGFloat = 2
    
    override func bindToViewModel() {
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
    
    func fetchData(){
        datas.value = (0...10).map {"\($0)"}
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = 5 * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
}


class RaoVatViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        
    }
    
    func bindData(data: String){
        title.text = data
    }
}

