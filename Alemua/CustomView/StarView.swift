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
    @IBInspectable var isSelectable: Bool = false

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }


    override public func awakeFromNib() {
        spacing = 2.5
        setupStar()
        if isSelectable {
            setupEvent()
        }
    }
    func setupStar() {
        distribution = .fillEqually
        alignment = .fill
        for index in 0..<5 {
            let image = UIButton()
            if index < number {
                image.setImage(fillStarImage, for: .normal)
            } else {
                image.setImage(unStarImage, for: .normal)
            }
            addArrangedSubview(image)
        }
    }

    func setupEvent() {
        subviews[0].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickStar0)))
        subviews[1].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickStar1)))
        subviews[2].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickStar2)))
        subviews[3].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickStar3)))
        subviews[4].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickStar4)))
    }


    func clickStar0() {
        print("ADSf 1")
        number = 1
        fillStar()
    }
    func clickStar1() {
        number = 2
        fillStar()
    }
    func clickStar2() {
        number = 3
        fillStar()
    }
    func clickStar3() {
        number = 4
        fillStar()
    }
    func clickStar4() {
        number = 5
        fillStar()
    }

    func fillStar() {
        for index in 0..<5 {
            if index < number {
                (subviews[index] as! UIButton).setImage(fillStarImage, for: .normal)
            } else {
                (subviews[index] as! UIButton).setImage(unStarImage, for: .normal)
            }
        }
    }
}
