//
//  RateDetail.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM

class RateDetail: AwesomeToggleViewByHeight {

    @IBOutlet weak var uiStackView: UIStackView!
    
    var listView: [AwesomeTextField] = []
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.setupView(nibName: "RateDetail")
        //7 item
        listView = uiStackView.arrangedSubviews.map { ($0 as! AwesomeTextField) }
        
    }
    
    public func setValues(values: [String]){
        for index in 0..<listView.count {
            listView[index].text = values[index]
        }
    }

}
