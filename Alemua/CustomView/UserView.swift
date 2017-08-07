//
//  UserView.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/27/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import Kingfisher

class UserView: BaseCustomView {
    var toggleView: (() -> Void)?
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nguoimua: UILabel!
    @IBOutlet weak var star: StarView!
    @IBOutlet weak var danhgia: UILabel!
    @IBOutlet weak var flag: UIImageView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.setupView(nibName: "UserView")
    }
    
    @IBAction func onToggleView(_ sender: Any) {
        if toggleView != nil {
            toggleView!()
        }
    }
    
    func bindData(data: ProfileData?, profileType: Int) {
        if let photo = data?.photo {
            avatar.kf.setImage(with: URL(string: photo))
        }
        name.text = data?.name ?? ""
        nguoimua.text = profileType == 1 ? "Người mua" : "Người vận chuyển"
        star.number = Int(data?.rating ?? 0)
        star.fillStar()
        danhgia.text = "\(data?.rating?.toFormatedRating() ?? "0")"
    }
    
    func bindData(photo: String?, name: String?, rating: Float? , profileType: Int) {
        if let photo = photo {
            avatar.kf.setImage(with: URL(string: photo))
        }
        self.name.text = name ?? ""
        nguoimua.text = profileType == 1 ? "Người mua" : "Người vận chuyển"
        star.number = Int(rating ?? 0)
        star.fillStar()
        danhgia.text = "\(rating?.toFormatedRating() ?? "0")"
    }
}
