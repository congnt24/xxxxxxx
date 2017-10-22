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
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var lbNull: UILabel!
    
    var parentUrl: String?
    var orderData: ModelOrderData?
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
//        let request = URLRequest(url: URL(string: text))
//        self.webView.loadRequest(request);
        input.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { () in
            self.openPage()
        }).addDisposableTo(bag)

        input.rx.text.subscribe(onNext: { (text) in
            if text == "" {
                self.btnClear.isHidden = true
            } else {
                self.btnClear.isHidden = false

            }
        }).addDisposableTo(bag)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        lbNull.isHidden = false
        if let parentUrl = parentUrl {
            if parentUrl != "" {
                input.text = parentUrl
                openPage()
            }
        }else
            if let orderData = orderData {
                print(orderData.websiteUrl)
                if let url = orderData.websiteUrl {
                    if url != "" {
                        input.text = url
                        openPage()
                    }
                }
        }
    }

    func openPage() {
        if let text = input.text {
            //format http
            let strUrl = text.convertToLink()
            if let url = URL(string: strUrl) {
                lbNull.isHidden = true
                let request = URLRequest(url: url)
                self.webView.loadRequest(request)
            }
        }
    }
    @IBAction func onClear(_ sender: Any) {
        self.input.text = ""
        btnClear.isHidden = true
    }

    @IBAction func onCancel(_ sender: Any) {
        navigationController?.popViewController()

    }

    @IBAction func onTaoDonHang(_ sender: Any) {
        OrderCoordinator.sharedInstance.showTaoDonHang(url: orderData?.websiteUrl ?? parentUrl , data: orderData)
        
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        if let text = webView.request?.url?.absoluteString{
            self.input.text = text
            self.parentUrl = text
        }
    }
}
