//
//  StarView.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

@IBDesignable
class StarView: UIStackView {
    @IBInspectable
    var unStarImage: UIImage?
    @IBInspectable
    var fillStarImage: UIImage?
    
    @IBInspectable
    var number: Int = 0
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStar()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStar()
    }
    
    
    override public func awakeFromNib() {
        setupStar()
    }

    func setupStar() {
        distribution = .fillEqually
        alignment = .fill
        for index in 0..<5 {
            let image = UIImageView()
            if index < number {
                image.image = fillStarImage
            }else{
                image.image = unStarImage
            }
            addArrangedSubview(image)
        }
    }
}
