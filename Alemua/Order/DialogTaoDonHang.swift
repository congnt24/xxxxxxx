//
//  DialogTaoDonHang.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/24/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import UIKit
import AwesomeMVVM
import Kingfisher

class DialogTaoDonHang: UIViewController {
    
    public static var shared: DialogTaoDonHang!
    @IBOutlet weak var input: AwesomeTextField!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    var data: CurrencyData? {
        didSet {
            label.text = data?.name
            if let p = data?.photo {
                photo.kf.setImage(with: URL(string: p))
            }
            
        }
    }
    override func viewDidLoad() {
        DialogTaoDonHang.shared = self
        photo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onChangeCurrency)))
    }
    
    @IBAction func onChangeCurrency(_ sender: Any) {
        AwesomeDialog.shared.show(vc: DialogTaoDonHang.shared, name: "Main", identify: "DialogTaoDonHang2")
    }
    @IBAction func onDone(_ sender: Any) {
        TaoDonHang1ViewController.sharedInstance.tfGia.text = input.text
        
    }
}
