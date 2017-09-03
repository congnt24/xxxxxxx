//
//  CheckedButton.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/26/17.
//  Copyright © 2017 cong. All rights reserved.
//


import Foundation
import UIKit

/// Using this in storyboard, you need to set unchecked button in image field of button
/// and checked button in checkedImage field
@IBDesignable
open class CheckedButton: UIButton {
    public var onChange: ((Bool) -> Void)?
    public var isChecked = false {
        didSet {
            if isChecked {
                if let onCheck = onChange {
                    onCheck(isChecked)
                }
            }
            setState(check: isChecked)
        }
    }
    public var normalImage: UIImage!
    @IBInspectable public var checkedImage: UIImage? = nil {
        didSet {
            normalImage = image(for: .normal)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //handle aciton here
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CheckedButton.changeState)))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    public func setState(check: Bool) {
        if !check {
            setImage(normalImage, for: .normal)
        } else {
            setImage(checkedImage, for: .normal)
        }
    }
    
    public func changeState() {
        isChecked = !isChecked
    }
}