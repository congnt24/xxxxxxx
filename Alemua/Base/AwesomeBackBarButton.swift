//
//  AwesomeBackBarButton.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

class AwesomeBackBarButton: UIBarButtonItem {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        target = self
        action = #selector(back(sender:))
    }
    
    func back(sender: UIBarButtonItem) {
        AppCoordinator.sharedInstance.back()
    }
}
