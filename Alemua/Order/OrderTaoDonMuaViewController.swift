//
//  OrderTaoDonMuaViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/26/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxCocoa
import RxSwift

class OrderTaoDonMuaViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var input: AwesomeTextField2!
    @IBOutlet weak var webView: UIWebView!
    
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
//        let request = URLRequest(url: URL(string: text))
//        self.webView.loadRequest(request);
        input.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { () in
            self.openPage()
        }).addDisposableTo(bag)
        
        input.onClearDelegate = {
            self.input.text = ""
        }
        // Do any additional setup after loading the view.
    }

    func openPage(){
        if let text = self.input.text {
            //format http
            let strUrl = text.hasPrefix("http://") || text.hasPrefix("https://") ? text : "http://\(text)"
            if let url = URL(string: strUrl) {
                let request = URLRequest(url: url)
                self.webView.loadRequest(request)
            }
        }
    }

    @IBAction func onCancel(_ sender: Any) {
        navigationController?.popViewController()
        
    }

}
