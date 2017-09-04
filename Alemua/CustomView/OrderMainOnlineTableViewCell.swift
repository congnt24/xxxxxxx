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

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var stack: UIStackView!
    var data: ModelBuyingOnline?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }


    func bindData(data: ModelBuyingOnline) {
        self.stack.removeSubviews()
        self.data = data
        let count = data.items!.count
        let width = Int(((bounds.width - 32) / 3)) * count + (count-1) * 8
        let wid = CGFloat(width/count)
        widthConstraint.constant = 0
        for item in data.items! {
            KingfisherManager.shared.retrieveImage(with: URL(string: item.photo!)!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                var img: OnlinePhoto!
                if let image = image {
                    img = OnlinePhoto(image: image)
                }else{
                    img = OnlinePhoto(image: UIImage(named: "no_image"))
                }
                
                img.data = item
                self.widthConstraint.constant += wid
                self.stack.addArrangedSubview(img)
            })
        }
    }
}


class OnlinePhoto: UIImageView {
    var data: ModelBuyingOnlineItem!
    
    override init(image: UIImage?) {
        super.init(image: image)
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectItem)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    func selectItem(){
        OrderCoordinator.sharedInstance.showTaoDonHang(data: nil, text: data.websiteUrl)
    }
}
