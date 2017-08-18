//
//  ChatRepository.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/17/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import RealmSwift

class Chat: Object {
    dynamic var userid = 0
    dynamic var sendtoid = 0
    dynamic var message: String?
}
class ChatRepository: Repository<Chat> {
    
}
