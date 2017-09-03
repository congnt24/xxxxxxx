//
//  UserView.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import Kingfisher

class RaoVatUserView: BaseCustomView {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        super.setupView(nibName: "RaoVatUserView")
    }
    
    func onAvatarClick(){
    }
    
    
    func bindData(name: String?, address: String?, photo: String?){
        self.name.text = name
        self.address.text = address
        if let p = photo {
            avatar.kf.setImage(with: URL(string: p), placeholder: UIImage(named: "no_image"))
        }
    }
}
