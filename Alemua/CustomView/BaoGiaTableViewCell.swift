//
//  BaoGiaTableViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/23/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import RxSwift

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
    
    let bag = DisposeBag()
    var data: ModelOrderBaoGiaData!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func bindData(data: ModelOrderBaoGiaData){
        self.data = data
        imProduct.setItem(url: data.userPhoto)
        lbName.text = data.userPost
        lbNote.text = data.note
        lbNoiMua.text = data.buyFrom
        lbDate.text = data.deliveryDate?.toFormatedDate()
        lbPrice.text = "\(data.totalPrice!)".toFormatedPrice()
        lbTime.text = "\(data.timeAgo!)"
        lbScore.text = "\(data.rating?.toFormatedRating() ?? "0")"
        star.number = Int(data.rating ?? 0)
        star.fillStar()
    }
    
    @IBAction func onXacNhan(_ sender: Any) {
    }
    
    @IBAction func onSendMessage(_ sender: Any) {
        AlemuaApi.shared.aleApi.request(AleApi.addChattingLog(user_receive_id: data.userPostId!))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result):
                    print("Add Chatting Log success")
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }
}
