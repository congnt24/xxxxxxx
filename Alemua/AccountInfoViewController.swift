//
//  AccountInfoViewController.swift
//  Alemua
//
//  Created by Nguyễn Công on 10/11/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class AccountInfoViewController: BaseViewController {
    
    @IBOutlet weak var titleBar: UINavigationItem!
    @IBOutlet weak var webview: UIWebView!
    var titleStr = ""
    var url = ""
    var coordinator: AccountCoordinator!
    let bag = DisposeBag()
    override func bindToViewModel() {
        titleBar.title = titleStr
        webview.loadRequest(URLRequest(url: URL(string: url)!))
    }
    
    override func responseFromViewModel() {
        
    }
    
}


