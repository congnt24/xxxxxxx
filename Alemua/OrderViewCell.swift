//
//  OrderViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/20/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import Kingfisher

class OrderViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPhoto: UIImageView!
    @IBOutlet weak var lbNoiMua: UILabel!
    @IBOutlet weak var lbWebsite: UILabel!
    @IBOutlet weak var lbGia: UILabel!
    @IBOutlet weak var lbGiaCu: StrikeThroughLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPhoto(link: String){
        productPhoto.kf.setImage(with: URL(string: link))
    }
    
    
    func bindData(item: ModelOrderData){
        productName.text = item.name
        lbNoiMua.text = item.address
        lbWebsite.text = item.websiteUrl
        lbGia.text = "$\(item.promotionPrice!)"
        lbGiaCu.text = "$\(item.originPrice!)"
        setPhoto(link: item.photo!)
    }
}
