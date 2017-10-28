//
//  RaoVatCateTableViewCell.swift
//  Alemua
//
//  Created by Nguyễn Công on 10/28/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import SwipeCellKit

class RaoVatCateTableViewCell: SwipeTableViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var discount: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var newItem: UILabel!
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var oldPrice: StrikeThroughLabel!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    func bindData(data: ProductResponse) {
        if let p = data.photo, p != "" {
            let arr = p.splitted(by: ",")
            photo.kf.setImage(with: URL(string: arr[0]), placeholder: UIImage(named: "no_image"))
        }else{
            photo.image = UIImage(named: "no_image")
        }
        if let pro = data.promotion, pro > 0 {
            discount.isHidden = false
            oldPrice.isHidden = false
            discount.setTitle("\(pro)%", for: .normal)
        } else {
            discount.isHidden = true
            oldPrice.isHidden = true
        }
        name.text = data.title
        distance.text = "\((data.distance ?? 0).toDistanceFormated())"
        if data.productType! == 1 {
            newItem.text = "Hàng mới"
        } else if data.productType! == 2 {
            newItem.text = "Hàng sang tay"
        } else {
            newItem.text = "Đã qua sử dụng"
        }
        oldPrice.setText(str: "\(data.price!)".toFormatedPrice())
        newPrice.text = "\(data.price! * (100 - (data.promotion ?? 0)) / 100)".toFormatedPrice()
        views.text = "\(data.numberViewed ?? 0)"
        duration.text = data.timeAgo?.toFormatedTime()
        duration.text = data.endDate?.toDate()?.toFormatedDuration()
    }
    
}
