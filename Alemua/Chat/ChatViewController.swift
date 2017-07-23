//
//  ChatViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Kingfisher

protocol MessageReceivedDelegate: class {
    func onMessageReceive(senderId: String, senderName: String,  text: String)
}

class ChatViewController: JSQMessagesViewController, MessageReceivedDelegate {
    
    var chatCoor: ChatCoordinator!
    private var messages = [JSQMessage]()
    private var isOutGoing = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //init delegate
        self.senderId = "asdasd"
        self.senderDisplayName = "Cong"
//        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = true
    }
//    
    //MARK: JSQMessageView
    //START COLLEVTION VIEW FUNC
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "avatar"), diameter: 30)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.blue)
        } else {
            return bubbleFactory?.incomingMessagesBubbleImage(with: UIColor.blue)
        }
    }
    
    //MARK: Action for JSQMessage
    //SENDING MESSAGE BUTTON
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        sendMessage(senderId: senderId, senderName: senderDisplayName, text: text)
        collectionView.reloadData()
        finishSendingMessage()
    }
    //Delegate to handle receiving text message
    //we need to display message to JSQMessageView
    func onMessageReceive(senderId: String, senderName: String, text: String) {
        messages.append(JSQMessage(senderId: senderId, displayName: senderName, text: text))
        collectionView.reloadData()
    }
    
    //Send message to server and append to view
    func sendMessage(senderId: String, senderName: String, text: String){
        messages.append(JSQMessage(senderId: senderId, displayName: senderName, text: text))
    }

}
