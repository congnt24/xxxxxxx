//
//  NotifyTableViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/23/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import Kingfisher

class NotifyTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(data: NotifyData) {
        subTitle.text = data.content
        title.text = "Notification"
        if let p = data.photo {
            photo.kf.setImage(with: URL(string: p))
        }
    }
}
