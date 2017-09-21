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
    var transaction_option: Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func bindData(data: ModelOrderBaoGiaData, transaction_option: Int?){
        self.data = data
        imProduct.setItem(url: data.userPhoto)
        lbName.text = data.userPost
        lbNote.text = data.note
        lbNoiMua.text = data.buyFrom
        lbDate.text = data.deliveryDate?.toFormatedDate()
        lbPrice.text = "\(data.totalPrice!)".toFormatedPrice()
        lbTime.text = "\(data.timeAgo!.toFormatedRaoVatTime())"
        lbScore.text = "\(data.rating?.toFormatedRating() ?? "0")"
        star.number = Int(data.rating ?? 0)
        star.fillStar()
        self.transaction_option = transaction_option ?? 1
    }
    
    @IBAction func onXacNhan(_ sender: Any) {
        OrderOrderCoordinator.sharedInstance.showBaoGiaDetailDialog1(id: data.orderId, quoteId: data.id, transaction_option: transaction_option)
    }
    
    @IBAction func onSendMessage(_ sender: Any) {
        AlemuaApi.shared.aleApi.request(AleApi.addChattingLog(user_receive_id: data.userPostId!))
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result):
                    
                    let friend = ConversationUserData()
                    friend.id = self.data.userPostId
                    friend.photo = self.data.userPhoto
                    friend.name = self.data.userPost
                    ChatCoordinator(OrderOrderCoordinator.sharedInstance.navigation).start(friend)
                    print("Add Chatting Log success")
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }
}
