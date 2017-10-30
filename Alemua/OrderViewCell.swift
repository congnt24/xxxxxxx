//
//  OrderViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/20/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import Kingfisher
import MarqueeLabel

class OrderViewCell: UITableViewCell {

    @IBOutlet weak var btnPromo: UIButton!
    @IBOutlet weak var productName: MarqueeLabel!
    @IBOutlet weak var productPhoto: UIImageView!
    @IBOutlet weak var lbNoiMua: UILabel!
    @IBOutlet weak var lbWebsite: MarqueeLabel!
    @IBOutlet weak var lbGia: UILabel!
    @IBOutlet weak var lbGiaCu: StrikeThroughLabel!
    var data: ModelOrderData!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productName.scrollDuration = 16
        lbWebsite.scrollDuration = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setPhoto(link: String?) {
        productPhoto.kf.setImage(with: URL(string: link ?? ""), placeholder: UIImage(named: "sample"))
    }


    func bindData(item: ModelOrderData) {
        self.data = item
        productName.text = item.name
        lbNoiMua.text = item.address
        lbWebsite.text = item.websiteUrl
        lbGia.text = "\(item.promotionPrice!)".toFormatedPrice()
        lbGiaCu.setText(str: "\(item.originPrice!)".toFormatedPrice())
        setPhoto(link: item.photo)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClick)))
        if let promo = item.promotionPercent {
            if promo == 0 {
                btnPromo.isHidden = true
                lbGiaCu.isHidden = true
                lbGia.text = "\(item.originPrice!)".toFormatedPrice()
            } else {
                lbGiaCu.isHidden = false
                btnPromo.isHidden = false
                btnPromo.setTitle("\(Int(promo))%", for: .normal)
            }
        }else{
            print("XXXX")
        }
    }

    func onClick() {
        OrderCoordinator.sharedInstance.showTaoDonHang(data: data)
    }
}
