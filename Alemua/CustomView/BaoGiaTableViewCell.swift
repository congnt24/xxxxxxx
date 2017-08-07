//
//  BaoGiaTableViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/23/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class BaoGiaTableViewCell: UITableViewCell {
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
        if let photo = data.userPhoto {
            photo.loadItemImage(img: imProduct)
        }
        lbName.text = data.userPost
        //        lbScore.text = data.
        lbNote.text = data.note
        lbNoiMua.text = data.buyFrom
        lbDate.text = data.deliveryDate?.toFormatedDate()
        lbPrice.text = "\(data.totalPrice!)".toFormatedPrice()
        lbTime.text = "\(data.timeAgo!)"
    }
    
    @IBAction func onXacNhan(_ sender: Any) {
    }
    
    @IBAction func onSendMessage(_ sender: Any) {
    }
}
