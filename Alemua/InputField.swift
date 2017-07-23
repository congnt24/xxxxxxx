//
//  InputField.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM

@IBDesignable
class InputField: UIView {

    private var inputLabel: UILabel!
    @IBInspectable public var content: String = "" {
        didSet {
            displayInputLabel(text: content)
        }
    }

    func displayInputLabel(text: String?) {
        if inputLabel == nil {
            inputLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
            inputLabel.backgroundColor = UIColor.red
            addSubview(inputLabel)
        }
        inputLabel.text = text
        inputLabel.frame.origin = CGPoint.zero
        inputLabel.sizeToFit()
//        view = UINib(nibName: "OrderViewCell", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
//        view.frame = self.bounds
//        
//        addSubview(view)
    }

    var view: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupView()
    }

    func setupView() {
        view = UINib(nibName: "InputField", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = self.bounds

        addSubview(view)
    }
}
