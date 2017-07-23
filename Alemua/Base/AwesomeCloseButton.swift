//
//  AwesomeCloseButton.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/23/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
class AwesomeCloseButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
    }
    
    func close(_ sender: UIBarButtonItem) {
        print("Close:")
        self.viewController()?.dismiss(animated: true, completion: nil)
    }

}
