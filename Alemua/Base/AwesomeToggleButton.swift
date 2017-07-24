//
//  AwesomeToggleButton.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/24/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class AwesomeToggleButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var image1: UIImage?
    @IBInspectable var image2: UIImage?
    
    var isToggle = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTarget(self, action: #selector(self.changeMe(_:)), for: .touchUpInside)
    }
    
    override func awakeFromNib() {
        setImage(image1, for: .normal)
    }
    
    func changeMe(_ sender: Any?){
        setImage(isToggle ? image1: image2, for: .normal)
        isToggle = !isToggle
        
    }

}
