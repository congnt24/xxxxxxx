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
    var inviteCode: String!
    @IBOutlet weak var tfInviteCode: AwesomeTextField!
    override func bindToViewModel() {
        tfInviteCode.text = inviteCode
    }
    
    
    override func responseFromViewModel() {
        
    }
    
    @IBAction func onInvite(_ sender: Any) {
    }
}

