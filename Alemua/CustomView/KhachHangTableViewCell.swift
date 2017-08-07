//
//  KhachHangTableViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/28/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import Kingfisher

class KhachHangTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var star: StarView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var lbBought: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(data: ClientResponse) {
        if let photo = data.photo {
            avatar.kf.setImage(with: URL(string: photo))
        }
        name.text = data.name
        star.number = Int(data.rating ?? 0)
        star.fillStar()
        score.text = "\(data.rating?.toFormatedRating() ?? "0")"
        lbBought.text = "\(data.numberProduct ?? 0)"
    }
    
}
