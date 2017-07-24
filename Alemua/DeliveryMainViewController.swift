//
//  DeliveryMainViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/24/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class DeliveryMainViewController: BaseViewController {
    @IBOutlet weak var containerView: UIView!
    var bag = DisposeBag()
    
    override func bindToViewModel() {
        self.addViewController(vcIdentifier: "Tab1")
    }
    
    override func responseFromViewModel() {
        
    }
    
    func addViewController(vcIdentifier: String) {
        let news = self.storyboard?.instantiateViewController(withIdentifier: vcIdentifier)
        news!.view.frame = containerView.bounds
        containerView.addSubview(news!.view)
        addChildViewController(news!)
        news!.didMove(toParentViewController: self)
    }
}
