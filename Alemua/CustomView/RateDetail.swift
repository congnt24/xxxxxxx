//
//  RateDetail.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM

struct RateDetailData {
    var tonggia: String
    var thue: String
    var phichuyennoidia: String
    var phinguoimua: String
    var phivanchuyenvealemua: String
    var phivanchuyenvetaynguoimua: String
    var phigiaodichquaalemua: String
    
}

class RateDetail: AwesomeToggleViewByHeight {

    @IBOutlet weak var uiStackView: UIStackView!
    @IBOutlet weak var tonggia: AwesomeTextField!
    @IBOutlet weak var thue: AwesomeTextField!
    @IBOutlet weak var phichuyennoidia: AwesomeTextField!
    @IBOutlet weak var phinguoimua: AwesomeTextField!
    @IBOutlet weak var phivanchuyenvealemua: AwesomeTextField!
    @IBOutlet weak var phivanchuyenvetaynguoimua: AwesomeTextField!
    @IBOutlet weak var phigiaodichquaalemua: AwesomeTextField!
    
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
    
    func bindData(_ rateData: RateDetailData){
        tonggia.text = rateData.tonggia
        thue.text = rateData.thue
        phichuyennoidia.text = rateData.phichuyennoidia
        phinguoimua.text = rateData.phinguoimua
        phivanchuyenvealemua.text = rateData.phivanchuyenvealemua
        phivanchuyenvetaynguoimua.text = rateData.phivanchuyenvetaynguoimua
        phigiaodichquaalemua.text = rateData.phigiaodichquaalemua
    }

}
