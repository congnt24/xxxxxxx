//
//  NotifyViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class NotifyViewController: BaseViewController {
    @IBOutlet weak var containerView: UIView!
    var coordinator: MainCoordinator!
    var bag = DisposeBag()
    
    override func bindToViewModel() {
        
    }
    
    override func responseFromViewModel() {
        
    }
}

