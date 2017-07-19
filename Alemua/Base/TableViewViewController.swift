//
//  TableViewViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import AwesomeMVVM
import RxCocoa
import RxSwift
import RxDataSources

class TableViewViewController: BaseViewController {
    var bad = DisposeBag()
    var viewModel = TableViewViewModel()
    override func bindToViewModel() {

    }
    override func responseFromViewModel() {

    }
}
