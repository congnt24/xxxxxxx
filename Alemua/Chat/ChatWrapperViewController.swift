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
    
    @IBOutlet weak var navBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = friend.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! ChatViewController).friend = friend
        (segue.destination as! ChatViewController).id_friend = id_friend
    }
}
