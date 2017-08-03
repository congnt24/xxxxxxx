//
//  AwesomeSwitch.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/1/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

@IBDesignable
class AwesomeSwitch: UISwitch {
    
    @IBInspectable var scaleX: CGFloat = 1.0
    @IBInspectable var scaleY: CGFloat = 1.0
    
    override func awakeFromNib() {
        transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
    }

}
