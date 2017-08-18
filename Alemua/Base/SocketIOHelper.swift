//
//  SocketIOHelper.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/9/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import SocketIO

class SocketIOHelper {
    func connectToSocketIO(){
        let socket = SocketIOClient(socketURL: URL(string: AppConstant.SOCKETIO_URL)!, config: [.log(true), .compress])
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on("currentAmount") {data, ack in
            if let cur = data[0] as? Double {
                socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
                    socket.emit("update", ["amount": cur + 2.50])
                }
                
                ack.with("Got your currentAmount", "dude")
            }
        }
        
        socket.connect()
    }
}

