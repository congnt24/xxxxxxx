//
//  OrderMainOnlineTableViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/28/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import Kingfisher

class OrderMainOnlineTableViewCell: UITableViewCell {

    @IBOutlet weak var item1: UIImageView!
    @IBOutlet weak var item2: UIImageView!
    @IBOutlet weak var item3: UIImageView!
    
    var data: ModelBuyingOnline?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        item1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectItem1)))
        item2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectItem2)))
        item3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectItem3)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }


    func bindData(data: ModelBuyingOnline) {
        self.data = data
        item1.kf.setImage(with: URL(string: (data.items?[0].photo)!))
        item2.kf.setImage(with: URL(string: (data.items?[1].photo)!))
        item3.kf.setImage(with: URL(string: (data.items?[2].photo)!))
    }
    
    func selectItem1(){
        if let data = data {
            OrderCoordinator.sharedInstance.showTaoDonHang(data: nil, text: data.items?[0].websiteUrl)
        }
    }
    func selectItem2(){
        if let data = data {
            OrderCoordinator.sharedInstance.showTaoDonHang(data: nil, text: data.items?[1].websiteUrl)
        }
    }
    func selectItem3(){
        if let data = data {
            OrderCoordinator.sharedInstance.showTaoDonHang(data: nil, text: data.items?[2].websiteUrl)
        }
    }
}
