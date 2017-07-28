//
//  AwesomeToggleViewByHeight.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/24/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

open class AwesomeToggleViewByHeight: BaseCustomView {

    @IBInspectable var isHide: Bool = false
    var heightConstraint: NSLayoutConstraint?
    var height: CGFloat!

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        heightConstraint = (self.constraints.filter { $0.firstAttribute == .height }.first)
        height = heightConstraint?.constant
    }

    override open func awakeFromNib() {
        if isHide {
            heightConstraint?.constant = 0
            self.alpha = 0
        }
    }

    open func toggleHeight() {
        if heightConstraint?.constant == 0 {
            heightConstraint?.constant = height
            self.alpha = 1
        } else {
            heightConstraint?.constant = 0
            self.alpha = 0
        }
    }

}
