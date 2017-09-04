//
//  AwesomeButton.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/20/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

@IBDesignable
class AwesomeButton: UIButton {
   
    // MARK: - bottom line
    @IBInspectable var bottomLineWidth: CGFloat = 0 {
        didSet {
            let border = CALayer()
            border.borderColor = UIColor.lightGray.cgColor
            border.frame = CGRect(x: 0, y: frame.size.height - bottomLineWidth, width: UIScreen.main.bounds.width, height: frame.size.height)
            border.borderWidth = bottomLineWidth
            layer.addSublayer(border)
            layer.masksToBounds = true
        }
    }
    @IBInspectable var bottomLineColor: UIColor = UIColor.red {
        didSet {
            let border = CALayer()
            border.borderColor = bottomLineColor.cgColor
            border.frame = CGRect(x: 0, y: frame.size.height - bottomLineWidth, width: UIScreen.main.bounds.width, height: frame.size.height)
            border.borderWidth = bottomLineWidth
            layer.addSublayer(border)
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable public var contentPadding: CGFloat = 0.0 {
        didSet {
            if contentPadding != 0 {
                self.contentEdgeInsets = UIEdgeInsets(top: 0, left: contentPadding, bottom: 0, right: 0)
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: contentPadding, bottom: 0, right: 0)
            }
        }
    }
    
    @IBInspectable public var leftAttachmentImage: UIImage? {
        didSet {
            if leftAttachmentImage != nil {
                if self.titleLabel != nil, self.titleLabel?.text != nil {
                    let text = "\(self.titleLabel!.text!)".localized()
                    self.setTitle(text, for: .normal)
                    self.setImage(leftAttachmentImage, for: .normal)
                }
            }
        }
    }
    
    @IBInspectable public var rightAttachmentImage: UIImage? {
        didSet {
            if rightAttachmentImage != nil {
                if self.titleLabel != nil, self.titleLabel?.text != nil {
                    let text = "\(self.titleLabel!.text!)".localized()
                    self.setTitle(text, for: .normal)
                    self.setImage(rightAttachmentImage, for: .normal)
                    self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.width - (self.imageView?.frame.width)! - 10, bottom: 0, right: 0)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
