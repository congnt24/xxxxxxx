//
//  ChatRepository.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/17/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Message: Object {
    private struct SerializationKeys {
        static let data = "data"
        static let id = "_id"
        static let typeAction = "typeAction"
        static let userSendName = "userSendName"
        static let userSend = "userSend"
        static let idSort = "idSort"
        static let userRecieve = "userRecieve"
        static let date = "date"
        static let timestamp = "timestamp"
        static let dataType = "dataType"
    }
    
    dynamic var userSend: String?
    dynamic var userSendName: String?
    dynamic var userSendPhoto: String?
    dynamic var userRecieve: String?
    dynamic var userRecieveName: String?
    dynamic var userRcievePhoto: String?
    dynamic var data: String?
    dynamic var dataType: Int = 0
    dynamic var idSort: Int = 0
    dynamic var date: String?
    dynamic var typeAction: Int = 0
    dynamic var timestamp: Int = 0
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public func bindData(json: JSON) -> Message {
        data = json[SerializationKeys.data].string
        typeAction = json[SerializationKeys.typeAction].int ?? 0
        userSendName = json[SerializationKeys.userSendName].string
        userSend = json[SerializationKeys.userSend].string
        idSort = json[SerializationKeys.idSort].int ?? 0
        userRecieve = json[SerializationKeys.userRecieve].string
        date = json[SerializationKeys.date].string
        timestamp = json[SerializationKeys.timestamp].int!
        dataType = json[SerializationKeys.dataType].int ?? 0
        
        return self
    }
    public func bindData(json2: JSON) -> Message {
        data = json2[SerializationKeys.data].string
        typeAction = json2[SerializationKeys.typeAction].int ?? 0
        userSendName = json2[SerializationKeys.userSendName].string
        userSend = json2[SerializationKeys.userSend].string
        idSort = json2[SerializationKeys.idSort].int ?? 0
        userRecieve = json2[SerializationKeys.userRecieve].string
        date = json2[SerializationKeys.date].string
        timestamp = Int(json2[SerializationKeys.timestamp].string!)!
        dataType = json2[SerializationKeys.dataType].int ?? 0
        
        return self
    }
    
    func toDict() -> [String: Any]{
        var params = [String: Any]()
        params["userSend"] = userSend!
        params["userSendName"] = userSendName
        params["userSendPhoto"] = userSendPhoto
        params["userRecieve"] = userRecieve!
        params["userRecieveName"] = userRecieveName
        params["userRcievePhoto"] = userRcievePhoto
        params["data"] = data
        params["dataType"] = dataType
        params["date"] = date!
        params["typeAction"] = typeAction
        params["timestamp"] = timestamp
        return params
    }

}


class MessageWrapper {
    var listMessage = [Message]()
    var charRepo = ChatRepository()
    init(json: String) {
        if let arr = JSON(data: json.data(using: String.Encoding.utf8)!).array {
            listMessage = arr.map({ Message().bindData(json: $0) })
        }
        
    }
    
    func saveToDB(){
        charRepo.addMessages(listMessage)
    }
}

class ChatRepository: Repository<Message> {
    
    override init() {
        super.init()
        
        debugPrint("Path to realm file: " + realm.configuration.fileURL!.absoluteString)
    }
    func addMessages(_ messages: [Message]){
        do {
            try realm.write {
                realm.add(messages, update: false)
            }
        } catch {
        }
    }
    func getLastMessage() -> Results<Message>{
        return realm.objects(Message.self).sorted(byKeyPath: "timestamp", ascending: false)
    }
    func getMessage(from: String, to: String) -> Results<Message> {
//        let filter = NSPredicate(format: "userSend == '%@' AND userRecieve == '%@'", from, to)//
        let filter = "(userSend = '\(from)' AND userRecieve = '\(to)') OR (userSend = '\(to)' AND userRecieve = '\(from)')"
        return realm.objects(Message.self).filter(filter).sorted(byKeyPath: "timestamp", ascending: true)
    }
}
