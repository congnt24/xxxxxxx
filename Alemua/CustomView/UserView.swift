//
//  UserView.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class UserView: BaseCustomView {
    var toggleView: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.setupView(nibName: "UserView")
    }
    
    @IBAction func onToggleView(_ sender: Any) {
        if toggleView != nil {
            toggleView!()
        }
    }
    
}
