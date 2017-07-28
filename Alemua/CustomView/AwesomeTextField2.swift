//
//  AwesomeTextField2.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/28/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM

@IBDesignable
class AwesomeTextField2: AwesomeTextField {
    var onClearDelegate: (() -> Void)?
    
    @IBInspectable
    public var rightButtonTintColor: UIColor = UIColor.white {
        didSet {
            let height = self.frame.height
            let width = self.frame.width
            rightButton = rightButton?.withRenderingMode(.alwaysTemplate)
            let btn = UIButton(type: .custom)
            btn.setImage(rightButton, for: .normal)
            btn.tintColor = rightButtonTintColor
            btn.setTitleColor(rightButtonTintColor, for: .normal)
            addSubview(btn)
            btn.frame = CGRect(x: width - height, y: 0, width: height, height: height)
            //            self.rightView = btn
            
            let tab = UITapGestureRecognizer(target: self, action: #selector(onClear))
            btn.addGestureRecognizer(tab)
        }
    }
    
    @IBInspectable var rightButton: UIImage? {
        didSet {
            let height = self.frame.height
            let width = self.frame.width
            rightButton = rightButton?.withRenderingMode(.alwaysTemplate)
            let btn = UIButton(type: .custom)
            btn.setImage(rightButton, for: .normal)
            btn.tintColor = rightButtonTintColor
            btn.setTitleColor(rightButtonTintColor, for: .normal)
            addSubview(btn)
            btn.frame = CGRect(x: width - height, y: 0, width: height, height: height)
//            self.rightView = btn
            
            let tab = UITapGestureRecognizer(target: self, action: #selector(onClear))
            btn.addGestureRecognizer(tab)
        }
    }
    
    func onClear(){
        if let onClearDelegate = onClearDelegate {
            onClearDelegate()
        }
    }

}
