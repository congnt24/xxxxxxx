//
//  ConversationTableViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/23/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import Kingfisher

class ConversationTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lbLastMessage: UILabel!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(data: ConversationUserData) {
        avatar.setAvatar(url: data.photo)
        name.text = data.name != "" ? data.name :"\(data.phoneNumber!)"
        lbLastMessage.text = data.last_message
        time.text = data.last_time!.toFormatedHour()
    }
}
