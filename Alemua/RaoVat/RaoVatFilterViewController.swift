//
//  BaoGiaViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import UIKit
import AwesomeMVVM
import RxSwift
import RxCocoa
import DropDown

class RaoVatFilterViewController: BaseViewController, UITextFieldDelegate {
    var bag = DisposeBag()
    
    @IBOutlet weak var tfSort: AwesomeTextField!
    @IBOutlet weak var tfCategory: AwesomeTextField!
    @IBOutlet weak var tfState: AwesomeTextField!
    @IBOutlet weak var tfPrice: AwesomeTextField!
    @IBOutlet weak var sliderDistance: UISlider!
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false;
    }
    
    let ddSort = DropDown()
    let ddCategory = DropDown()
    let ddState = DropDown()
    let ddPrice = DropDown()
    override func bindToViewModel() {
        ddSort.anchorView = tfSort
        ddSort.dataSource = ["1", "2", "3"]
        ddSort.width = 180
        ddSort.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfSort.text = item
        }
        
        ddCategory.anchorView = tfCategory
        ddCategory.dataSource = ["1", "2", "3"]
        ddCategory.width = 180
        ddCategory.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfCategory.text = item
        }
        
        ddState.anchorView = tfState
        ddState.dataSource = ["1", "2", "3"]
        ddState.width = 180
        ddState.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfState.text = item
        }
        
        ddPrice.anchorView = tfPrice
        ddPrice.dataSource = ["1", "2", "3"]
        ddPrice.width = 180
        ddPrice.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfPrice.text = item
        }
        
        
    }
    
    
    func onSort() {
        ddSort.show()
    }
    func onCategory() {
        ddCategory.show()
    }
    func onState() {
        ddState.show()
    }
    func onPrice() {
        ddPrice.show()
    }
    
    
    
    override func responseFromViewModel() {
        
    }
    @IBAction func onSliderChange(_ sender: Any) {
    }
    @IBAction func onSearch(_ sender: Any) {
    }
    @IBAction func onResetFilter(_ sender: Any) {
    }
}

