//
//  HomeViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {
    var coordinator: HomeCoordinator!
    var bag = DisposeBag()
    
    override func bindToViewModel() {
    }
    
    override func responseFromViewModel() {
        
    }

    @IBAction func onClickChat(_ sender: Any) {
        coordinator.showChatScreen()
    }
}
