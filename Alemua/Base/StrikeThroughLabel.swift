//
//  StrikeThroughLabel.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/1/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

@IBDesignable
class StrikeThroughLabel: UILabel {
    override func awakeFromNib() {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text!)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        attributedText = attributeString
    }
    public func setText(str: String){
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: str)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        attributedText = attributeString
    }
}
