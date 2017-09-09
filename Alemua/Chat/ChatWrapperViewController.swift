//
//  ChatWrapperViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class ChatWrapperViewController: UIViewController {
    var friend: ConversationUserData!
    var id_friend: Int?
    var data: String?
    
    @IBOutlet weak var navBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let data = data {
            let users = data.splitted(by: ",")
            friend = ConversationUserData()
            friend.id = Int(users[0])
            if users.count > 1 {
                friend.name = users[1]
            } else {
                friend.name = "No Name"
            }
            if users.count > 2 {
                friend.photo = users[2]
            } else {
                friend.photo = ""
            }
        }
        
        navBar.title = friend.name
        (segue.destination as! ChatViewController).friend = friend
        (segue.destination as! ChatViewController).data = data
    }
    
    
    
    func fetchUserDataFromId(){
        if id_friend != nil {
//            AlemuaApi.shared.aleApi.request(AleApi.getListUsersToChat())
//                .toJSON()
//                .subscribe(onNext: { (res) in
//                    switch res {
//                    case .done(let result, _):
//                        if let result = result.array {
//                            var users = result.map { ConversationUserData(json: $0) }
//                            users = users.filter { $0.id! == self.id_friend! }
//                            if users.count > 0 {
//                                SocketIOHelper.shared.emitLoadMessage(receiveId: self.id_friend!)
//                            }
//                            
//                            
//                        }
//                        break
//                    case .error(let msg):
//                        print("Error \(msg)")
//                        break
//                    }
//                }).addDisposableTo(bag)
        }
    }
}
