//
//  SocketIOHelper.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/9/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import SocketIO
import SwiftyJSON

public class SocketIOHelper {
    public static var shared: SocketIOHelper!

    var chatRepo = ChatRepository()
    var socket: SocketIOClient!
    init() {
        SocketIOHelper.shared = self
        connectToSocketIO()
    }
    func connectToSocketIO() {
        if !Prefs.isUserLogged {
            return
        }
        
        socket = SocketIOClient(socketURL: URL(string: AppConstant.SOCKETIO_URL)!, config: [.log(true), .compress])
        print(Prefs.userId)
        socket.on(clientEvent: .connect) { data, ack in
            print("socket connected")
            //Emit online status
            self.socket.emit("UserOnline", "\(Prefs.userId)")
        }

        socket.on("\(Prefs.userId)LoadMessage") { (data, ack) in
            print("Load message success ")
            let array = (data[0] as! NSDictionary)["Content"] as! NSArray
            print("xxxxxx \(array.count)")
            let mw = MessageWrapper(json: array.map({ $0 }).toJSONString())
            mw.saveToDB()
        }
        
        //receive
        socket.on("\(Prefs.userId)") { (data, ack) in
            print("Receive message")
            let dict = ((data[0] as! NSDictionary)["Content"] as! NSDictionary)
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
                let str =  String(data: jsonData, encoding: String.Encoding.utf8)!
                let message = Message().bindData(json: JSON(data: str.data(using: String.Encoding.utf8)!))
//                print(message)
                self.chatRepo.add(message)

            } catch {
                print("Error")
            }
        }
        
        socket.on("\(Prefs.userId)CorrectTime") { (data, ack) in
            print("correct time")
            let dict = ((data[0] as! NSDictionary)["Content"] as! NSDictionary)
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
                let str =  String(data: jsonData, encoding: String.Encoding.utf8)!
                let message = Message().bindData(json: JSON(data: str.data(using: String.Encoding.utf8)!))
//                print(message)
                self.chatRepo.add(message)
                
            } catch {
                print("Error")
            }
        }
        
        socket.on("\(Prefs.userId)StopTyping") { (data, ack) in
            print(data)
        }
        socket.on("\(Prefs.userId)Sent") { (data, ack) in
            print(data)
        }
        socket.on("\(Prefs.userId)NumberMessage") { (data, ack) in
            print(data)
        }
        socket.connect()
    }

    func emitLoadMessage(receiveId: Int) {
        let last = chatRepo.getLastMessage()
        var timestamp = 0
        if last.count > 0 {
            timestamp = last.first!.timestamp
            print(timestamp)
        }
        socket.emit("LoadMessage", ["userSend": "\(Prefs.userId)", "userRecieve": "\(receiveId)", "timestamp": timestamp])
    }
    
    func emitSendToServer(message: Message) {
        socket.emit("SendToServer", message.toDict())
    }

    func emitTyping(receiveId: Int) {
        socket.emit("Typing", ["userRecieve": receiveId])

    }
    func emitStopTyping(receiveId: Int) {
        socket.emit("StopTyping", ["userRecieve": receiveId])

    }

    func disconnectToSocketIO() {
        socket.emit("disconnect")
        socket.disconnect()
    }
    func clearAllSubscribe() {
        socket.removeAllHandlers()
    }

}

