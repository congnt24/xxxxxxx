//
//  AwesomeToggleViewByHeight.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/24/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class AwesomeToggleViewByHeight: UIView {
    
    @IBInspectable var isHide: Bool = false
    var heightConstraint: NSLayoutConstraint?
    var height: CGFloat!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        heightConstraint = (self.constraints.filter { $0.firstAttribute == .height }.first)
        height = heightConstraint?.constant
    }
    
    override func awakeFromNib() {
        if isHide {
            heightConstraint?.constant = 0
        }
    }

    public func toggleHeight() {
        heightConstraint?.constant = heightConstraint?.constant == 0 ? height : 0
    }

}
