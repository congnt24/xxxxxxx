//
//  PhotoView.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/7/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class PhotoView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
        self.contentMode = .scaleAspectFill
        let constraintWidth = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 95.0
        )
        let constraintHeight = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 95.0
        )
        addConstraint(constraintWidth)
        addConstraint(constraintHeight)
        cornerRadius = 4
        borderWidth = 1
        borderColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
