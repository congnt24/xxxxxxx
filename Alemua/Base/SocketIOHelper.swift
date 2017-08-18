//
//  SocketIOHelper.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/9/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import SocketIO

public class SocketIOHelper {
    public static var shared: SocketIOHelper!
    var socket: SocketIOClient!
    init() {
        SocketIOHelper.shared = self
        connectToSocketIO()
    }
    func connectToSocketIO(){
        socket = SocketIOClient(socketURL: URL(string: AppConstant.SOCKETIO_URL)!, config: [.log(true), .compress])
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on("16LoadMessage"){ (data, ack) in
            print("Load mesage success ")
            print(data)
        }

        
        
        //Emit online status
        socket.emit("UserOnline", 16)
        socket.connect()
    }
    
    func emitLoadMessage(){
        socket.emit("LoadMessage", ["userSend": 16, "userRecieve": 14, "timestamp": 0])
    }
    
    
    
    
    
    func disconnectToSocketIO(){
        socket.disconnect()
    }
    func clearAllSubscribe(){
        socket.removeAllHandlers()
    }
    
}

