//
//  StepperView.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/28/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class StepperView: BaseCustomView {

    @IBOutlet weak var lbNumber: UILabel!
@IBInspectable var number: Int = 1 {
        didSet {
            if let onChange = onChange {
                onChange(number)
            }
        }
    }
    
    public var onChange: ((Int) -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.setupNormalView(nibName: "StepperView")
    }
    
    override func awakeFromNib() {
        lbNumber.text = "\(number)"
    }
    
    @IBAction func onAdd(_ sender: Any) {
        number += 1
        lbNumber.text = "\(number)"
    }
    @IBAction func onMinus(_ sender: Any) {
        if number > 1 {
            number -= 1
            lbNumber.text = "\(number)"
        }
    }
}
