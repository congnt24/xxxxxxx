//
//  DeliveryTableViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/23/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import Kingfisher
import MarqueeLabel

class DeliveryTableViewCell: UITableViewCell {
    @IBOutlet weak var title: MarqueeLabel!

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbOwner: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbBaoGia: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var btnBaoGia: UIButton!
    
    var onClickBaoGia: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        title.scrollDuration = 16
    }
    
    @IBAction func onClickBaogia(_ sender: UIButton) {
        print("ASdasdasd")
        if let onClickBaoGia = onClickBaoGia {
            onClickBaoGia()
        }
    }
    
    func bindData(data: ModelQuoteData){
        let processor = ResizingImageProcessor(referenceSize: CGSize(width: 100, height: 100))
        if data.photo != "" {
            img.kf.setImage(with: URL(string: data.photo!.splitted(by: ",")[0]), placeholder: UIImage(named: "sample") , options: [.processor(processor)])
        }else{
            img.image = UIImage(named: "sample")
        }
        title.text = data.productName
        lbOwner.text = data.userPost
        lbDate.text = data.deliveryDate?.toFormatedDate()
        lbBaoGia.text = "\(data.numberQuote ?? 0)".toFormatedBaoGia()
        lbAddress.text = data.buyFrom ?? ""
        lbPrice.text = "\(data.websitePrice ?? 0)".toFormatedPrice()
        lbTime.text = data.timeAgo?.toFormatedTime()
        if data.is_quote == 1 {
            btnBaoGia.isHidden = true
        }else{
            btnBaoGia.isHidden = false
        }
    }
}
