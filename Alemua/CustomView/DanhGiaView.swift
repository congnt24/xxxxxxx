//
//  DanhGiaView.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class DanhGiaView: BaseCustomView {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var star: StarView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.setupNormalView(nibName: "DanhGiaView")
    }
}
