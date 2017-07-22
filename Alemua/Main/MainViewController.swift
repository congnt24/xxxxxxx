//
//  MainTableViewCell.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/22/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

class MainViewController: BaseViewController {
    @IBOutlet weak var containerView: UIView!
        var coordinator: MainCoordinator!
    var bag = DisposeBag()
    
    override func bindToViewModel() {
        switch NavTabBarViewController.AlemuaType {
        case .Order:
            self.addViewController(vcIdentifier: "Tab1")
            break
        case .Delivery:
            self.addViewController(vcIdentifier: "Tab2")
            break
        }
    }
    
    override func responseFromViewModel() {
        
    }
    func test() {
        print("Hello world")
    }
    
    
    func addViewController(vcIdentifier: String) {
        let news = self.storyboard?.instantiateViewController(withIdentifier: vcIdentifier)
        news!.view.frame = containerView.bounds
        containerView.addSubview(news!.view)
        addChildViewController(news!)
        news!.didMove(toParentViewController: self)
    }
}

