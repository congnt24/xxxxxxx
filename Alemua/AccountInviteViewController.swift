//
//  AccountInviteViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class AccountInviteViewController: BaseViewController {
    var coordinator: AccountCoordinator!
    override func bindToViewModel() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello World")
    }
    
    override func responseFromViewModel() {
        
    }
}
