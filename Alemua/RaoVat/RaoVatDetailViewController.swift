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

class RaoVatDetailViewController: BaseViewController {
    var bag = DisposeBag()
    
    override func bindToViewModel() {
        
    }
    
    override func responseFromViewModel() {
        
    }
    @IBAction func onBinhLuan(_ sender: Any) {
        RaoVatCoordinator.sharedInstance.showRaoVatComment(data: "")
    }
    @IBAction func onGoiDien(_ sender: Any) {
    }
    @IBAction func onGuiSMS(_ sender: Any) {
    }
}

