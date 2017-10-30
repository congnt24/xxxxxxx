//
//  DonHangTableViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import Kingfisher
import MarqueeLabel

class DonHangTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: MarqueeLabel!
    @IBOutlet weak var lbGiadexuat: UILabel!
    @IBOutlet weak var lbGiamua: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lblbGiaMua: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        name.scrollDuration = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func bindData(data: ModelOrderClientData){
        let processor = ResizingImageProcessor(referenceSize: CGSize(width: 100, height: 100))
        if data.photo != "" {
            photo.kf.setImage(with: URL(string: data.photo!.splitted(by: ",")[0]), placeholder: UIImage(named: "sample") , options: [.processor(processor)])
        }else{
            photo.image = UIImage(named: "sample")
        }
        name.text = data.productName
        lbGiadexuat.text = "\(data.websitePrice ?? 0)".toFormatedPrice()
        lbGiamua.text = "\(data.totalPrice ?? 0)".toFormatedPrice()
        lbAddress.text = data.buyFrom
        lbDate.text = data.deliveryDate?.toFormatedDate()

    }
    
    func invisibleGiaMua(){
        lbGiamua.isHidden = true
        lblbGiaMua.isHidden = true
    }
}
