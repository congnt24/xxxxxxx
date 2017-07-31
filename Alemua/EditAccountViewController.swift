//
//  EditAccountViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class EditAccountViewController: BaseViewController {
    @IBOutlet weak var uiMoreDetails: AwesomeToggleViewByHeight!

    @IBOutlet weak var tfTen: AwesomeTextField!
    @IBOutlet weak var tfDiachi: AwesomeTextField!
    @IBOutlet weak var tfEmail: AwesomeTextField!
    @IBOutlet weak var tfGioithieu: AwesomeTextField!
    @IBOutlet weak var userView: UserView!
    var coordinator: AccountCoordinator!
    override func bindToViewModel() {
        userView.toggleView = {
            self.uiMoreDetails.toggleHeight()
        }


    }
    
    override func responseFromViewModel() {

    }
    @IBAction func onDone(_ sender: Any) {
    }
}

