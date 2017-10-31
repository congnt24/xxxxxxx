//
//  PhotoView.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/7/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class PhotoView: UIImageView {
    
    var onDeleteDelegate: (() -> Void)?
    override init(image: UIImage?) {
        super.init(image: image)
        let close = UIButton()
        close.frame = CGRect(x: 75, y: 0, width: 20, height: 20)
        close.setImage(UIImage(named: "icons8-cancel_filled"), for: .normal)
//        close.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDelete)))
        close.addTarget(self, action: #selector(self.onDelete), for: .touchUpInside)
        close.isUserInteractionEnabled = true
        isUserInteractionEnabled = true
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
        addSubview(close)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func onDelete() {
        print("ondelete")
        removeFromSuperview()
        if let onon = onDeleteDelegate {
            onon()
        }
        
    }
}
