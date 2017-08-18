//
//  BaoGiaDeliveryTableViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/28/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import Kingfisher

class BaoGiaDeliveryTableViewCell: UITableViewCell {

    @IBOutlet weak var imProduct: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var star: StarView!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbNote: UILabel!
    @IBOutlet weak var lbNoiMua: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func bindData(data: ModelOrderBaoGiaData){
        imProduct.setItem(url: data.userPhoto)
        lbName.text = data.userPost
        lbNote.text = data.note
        lbNoiMua.text = data.buyFrom
        lbDate.text = data.deliveryDate?.toFormatedDate()
        lbPrice.text = "\(data.totalPrice!)".toFormatedPrice()
        lbTime.text = "\(data.timeAgo!.toFormatedTime())"
        lbScore.text = "\(data.rating?.toFormatedRating() ?? "0")"
        star.number = Int(data.rating ?? 0)
        star.fillStar()
    }

    
}
