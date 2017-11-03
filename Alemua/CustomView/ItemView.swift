//
//  ItemView.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/26/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import Kingfisher

struct ItemViewData {
    var title: String
    var imageUrl: String
    var baogia: String?
}

class ItemView: BaseCustomView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var baogia: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.setupView(nibName: "ItemView")
    }

    func bindData(_ itemViewData: ItemViewData) {
        title.text = itemViewData.title
        baogia.text = itemViewData.baogia!.toFormatedBaoGia()
        image.kf.setImage(with: URL(string: itemViewData.imageUrl))
    }
    func bindData(title: String?, imageUrl: String?, baogia: String?) {
        self.title.text = title
        if let bg = baogia{
            self.baogia.text = bg.toFormatedBaoGia()
        }else {
            self.baogia.text = ""
        }
        if let imageUrl = imageUrl {
            let arr = imageUrl.splitted(by: ",")
            image.setItem(url: (arr.count == 0 ? "" : arr[0]))
        }
    }
    
    func hideBaoGia() {
        baogia.isHidden = true
    }

}
