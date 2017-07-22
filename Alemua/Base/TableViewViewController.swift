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
    
    override func bindToViewModel() {
        
    }
    override func responseFromViewModel() {

    }
    
    
    
    //Interact API
    func fetchData() -> Observable<[String]>{
        return Observable.just((0..<20).map{"\($0)"})
    }
}
