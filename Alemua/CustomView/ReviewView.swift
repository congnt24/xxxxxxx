//
//  ReviewView.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM



class ReviewView: BaseCustomView {

    @IBOutlet weak var lbNguoidang: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imFlag: UIImageView!
    @IBOutlet weak var star: StarView!
    @IBOutlet weak var lbDanhgia: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.setupView(nibName: "ReviewView")
    }
    
    func bindData(){
        
    }

}
