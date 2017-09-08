//
//  HomeViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa

enum HomeType {
    case delivery
    case order
    case adv
}
class HomeViewController: BaseViewController {
    public static var homeType = HomeType.order
    var coordinator: HomeCoordinator!
    var bag = DisposeBag()
    
    override func bindToViewModel() {
    }
    
    override func responseFromViewModel() {
        
    }
    
    @IBAction func onClickDelivery(_ sender: UIButton) {
        coordinator.showDeliveryScreen()
        HomeViewController.homeType = .delivery
    }
    
    @IBAction func onClickOrder(_ sender: UIButton) {
        coordinator.showOrderScreen()
        HomeViewController.homeType = .order
    }
    @IBAction func onRaoVat(_ sender: Any) {
        coordinator.showRaoVatScreen()
        HomeViewController.homeType = .adv
    }

}
