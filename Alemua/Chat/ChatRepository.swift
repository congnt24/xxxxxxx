//
//  ChatRepository.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/17/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import RealmSwift

class Message: Object {
    dynamic var userSend = 0
    dynamic var userSendName: String?
    dynamic var userSendPhoto: String?
    dynamic var userRecieve = 0
    dynamic var userRecieveName: String?
    dynamic var userRcievePhoto: String?
    dynamic var data: String?
    dynamic var dataType = 0
    dynamic var idSort = 0
    dynamic var date: String?
    dynamic var typeAction = 0
    dynamic var timestamp: String?
}
class ChatRepository: Repository<Message> {
    func addMessages(_ messages: [Message]){
        realm.add(messages, update: false)
    }
    func getLastMessage(){
        realm.objects(Message.self).sorted(byKeyPath: "timestamp", ascending: false)
    }
}
