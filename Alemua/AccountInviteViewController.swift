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
    @IBOutlet weak var lbDesc: UILabel!
    override func bindToViewModel() {
        tfInviteCode.text = inviteCode
        lbDesc.text = "Mình đã dùng thử Alemua và thấy đây là ứng dụng mua và bán hàng xách tay tiện lợi và giá cạnh tranh nhất nên muốn giới thiệu cho bạn. Nhớ nhập mã giớp thiệu \(inviteCode ?? "") để nhân được nhiều ưu đãi khi tải ứng dụng lần đầu nhé"
    }
    
    
    override func responseFromViewModel() {
        
    }
    
    @IBAction func onInvite(_ sender: Any) {
        "Alemua".share(vc: self)
    }
}

