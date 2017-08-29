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

class RaoVatMenuViewController: BaseViewController {
    var bag = DisposeBag()
    
    @IBOutlet weak var uiSwitch: AwesomeSwitch!
    override func bindToViewModel() {
        
    }
    
    override func responseFromViewModel() {
        
    }
    @IBAction func onTrangChu(_ sender: Any) {
    }
    @IBAction func onProfile(_ sender: Any) {
        RaoVatCoordinator.sharedInstance.showRaoVatProfile(data: "")
    }
    @IBAction func onFavorite(_ sender: Any) {
    }
    @IBAction func onPublished(_ sender: Any) {
    }
    @IBAction func onNotify(_ sender: Any) {
        uiSwitch.isOn = !uiSwitch.isOn
    }
    @IBAction func onSwitchNotify(_ sender: Any) {
    }
}

