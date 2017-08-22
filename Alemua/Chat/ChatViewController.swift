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
import SocketIO
import RxRealm
import RxSwift

protocol MessageReceivedDelegate: class {
    func onMessageReceive(senderId: String, senderName: String, text: String)
}

class ChatViewController: JSQMessagesViewController, MessageReceivedDelegate {
    var chatRepo = ChatRepository()
    var messages = [JSQMessage]()
    var isOutGoing = true;
    let bag = DisposeBag()
    var friend: ConversationUserData!

    override func viewDidLoad() {
        super.viewDidLoad()
        //init delegate
        self.senderId = "\(Prefs.userId)"
        self.senderDisplayName = "Cong"
//        navigationController?.navigationBar.isHidden = false
        //change send item on inputtoolbar
        let rightButton = UIButton(frame: CGRect.zero)
        let sendImage = UIImage(named: "ic_send_message")
        rightButton.setImage(sendImage, for: .normal)
        self.inputToolbar.contentView.rightBarButtonItemWidth = CGFloat(10.0)
        self.inputToolbar.contentView.rightBarButtonItem = rightButton
        self.inputToolbar.contentView.leftBarButtonItem = nil
        self.inputToolbar.contentView.textView.placeHolder = "Nhập tin nhắn"
        self.inputToolbar.contentView.textView.backgroundColor = UIColor.clear
        self.inputToolbar.contentView.textView.borderWidth = 0
        self.inputToolbar.contentView.backgroundColor = UIColor.white
//        backgroundColor = UIColor.red
        self.collectionView.backgroundColor = UIColor.init(hexString: "#F2F1F1")

        //TODO: Get messages from db

        //        messages
        let result = chatRepo.getMessage(from: senderId, to: "\(friend.id!)").toArray()
        print(result.count)
        for res in result {
            messages.append(JSQMessage(senderId: "\(res.userSend!)", displayName: "", text: res.data))
        }
        collectionView.reloadData()
        //observable
        observerFromRealm()

    }

    override func viewDidDisappear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = true
//        disconnect()

    }
//
    //MARK: JSQMessageView
    //START COLLEVTION VIEW FUNC
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            cell.textView.textColor = UIColor.white
        } else {
            cell.textView.textColor = UIColor.init(hexString: "E94F2E")
            
        }
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

//        let tailessIncomingBubble = JSQMessagesBubbleImageFactory(bubble: UIImage(named: "tailessMessageBubble"), capInsets: UIEdgeInsets.zero).incomingMessagesBubbleImage(with: UIColor.white)
        if message.senderId == senderId {
            return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.init(hexString: "E94F2E"))
        } else {
            return bubbleFactory?.incomingMessagesBubbleImage(with: UIColor.white)

        }
    }

    //MARK: Action for JSQMessage
    //SENDING MESSAGE BUTTON
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        sendMessage(sendTo: "\(friend.id!)", senderName: senderDisplayName, text: text)
        collectionView.reloadData()
        finishSendingMessage()
    }
}


// MARK: - Interact with socket io

extension ChatViewController {
//    func disconnect() {
//        SocketIOHelper.shared.clearAllSubscribe()
//    }

    //Delegate to handle receiving text message
    //we need to display message to JSQMessageView
    func onMessageReceive(senderId: String, senderName: String, text: String) {
        messages.append(JSQMessage(senderId: senderId, displayName: senderName, text: text))
        collectionView.reloadData()
    }
    //Send message to server and append to view
    func sendMessage(sendTo: String, senderName: String, text: String) {
        let message = Message()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        message.timestamp = Int(Date().timeIntervalSince1970) * 1000
        message.date = dateFormatter.string(from: Date())
        message.userSend = senderId
        message.userSendName = senderName
        message.userRecieve = sendTo
        message.data = text
        //TODO: Save to realm
//        chatRepo.addMessages([message])
        
        SocketIOHelper.shared.emitSendToServer(message: message)

//        messages.append(JSQMessage(senderId: senderId, displayName: senderName, text: text))
    }

    func observerFromRealm() {
        //Handle send and receive
        Observable.changeset(from: chatRepo.getMessage(from: senderId, to: "\(friend.id!)"))
            .subscribe(onNext: { (chats, changes) in
                if let changes = changes {
                    let indexes = changes.inserted

                    for index in indexes {
                        if chats[index].userSend! == self.senderId {
                            print("asdASdasdas das das das das das")
                        }
                        self.messages.append(JSQMessage(senderId: "\(chats[index].userSend!)", displayName: "", text: chats[index].data))
                    }
                    self.collectionView.reloadData()
                } else {
                }
            }).addDisposableTo(bag)
        
    }
}
