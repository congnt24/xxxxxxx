//
//  ChatCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import AwesomeMVVM
import UIKit

class ChatCoordinator: Coordinator {
    override func start(_ data: Any?) {
//        let chat: ConversationViewController = mainStoryboard.instantiateViewController(withClass: ConversationViewController.self)
        //create and assign view model
        //create and assign delegate = self
        //push navigation
        //        let viewModel = HomeViewModel(delegate: self)
        //        viewModel.delegate = self
        //        home.viewModel = viewModel
//        chat.chatCoor = self
//        navigation?.pushViewController(chat)
        //        navigation?.pushViewController(home, animated: true)
        let chat: ChatWrapperViewController = mainStoryboard.instantiateViewController(withClass: ChatWrapperViewController.self)
        chat.friend = data as! ConversationUserData
        //        chat.chatCoor = self
        navigation?.pushViewController(chat)
    }
}

extension ChatCoordinator {
    func showChatScreen(friend: ConversationUserData) {
        let chat: ChatWrapperViewController = mainStoryboard.instantiateViewController(withClass: ChatWrapperViewController.self)
        chat.friend = friend
        navigation?.pushViewController(chat)
    }
}
