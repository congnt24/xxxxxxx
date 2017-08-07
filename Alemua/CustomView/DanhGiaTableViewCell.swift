//
//  DanhGiaTableViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/7/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class DanhGiaTableViewCell: UITableViewCell {

    @IBOutlet weak var danhGiaView: DanhGiaView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(commentData: CommentData){
        danhGiaView.bindData(commentData: commentData)
    }

    
}
