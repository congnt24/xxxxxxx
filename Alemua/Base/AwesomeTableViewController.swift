//
//  AwesomeTableViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/20/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable
class AwesomeTableViewController: UITableView {

    @IBInspectable var nibName: String?
    var bag = DisposeBag()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }

    override func awakeFromNib() {
        if let nibName = nibName {
            let nib = UINib(nibName: nibName, bundle: nil)
            self.register(nib, forCellReuseIdentifier: nibName)

            fetchData().bind(to: self.rx.items(cellIdentifier: nibName)) { (row, item, cell) in

            }.addDisposableTo(bag)
        }

        self.estimatedRowHeight = 96 // some constant value
        self.rowHeight = 96
    }



    //Interact API
    func fetchData() -> Observable<[String]> {
        return Observable.just((0..<20).map { "\($0)" })
    }
}
