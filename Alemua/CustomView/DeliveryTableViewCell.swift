//
//  DeliveryTableViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/23/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import Kingfisher

class DeliveryTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbOwner: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbBaoGia: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    var onClickBaoGia: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onClickBaogia(_ sender: UIButton) {
        print("ASdasdasd")
        if let onClickBaoGia = onClickBaoGia {
            onClickBaoGia()
        }
    }
    
    func bindData(data: ModelQuoteData){
//        img.kf.setImage(with: URL(string: data.photo!.splitted(by: ",")[0]))
        lbOwner.text = data.userPost
        lbDate.text = data.deliveryDate
        lbBaoGia.text = String(describing: data.websitePrice)
        lbAddress.text = data.deliveryTo
//        lbTime.text = data.websitePrice
    }
}
