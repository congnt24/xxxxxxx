//
//  OrderMainHeaderTableViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/28/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class OrderMainHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var xemthem: UIView!
    
    var onXemThemDelegate: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        xemthem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onXemThem)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onXemThem(){
        if let onXemThemDelegate = onXemThemDelegate {
            onXemThemDelegate()
        }
    }
    
}
