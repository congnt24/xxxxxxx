//
//  InputField.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM

class InputField: UIView {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var input: AwesomeTextField!
    @IBInspectable var textLabel: String = "" {
        didSet {
            label.text = textLabel
        }
    }
    var view: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
        view = UINib(nibName: "InputField", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = self.bounds
        
        addSubview(view)
    }
}
