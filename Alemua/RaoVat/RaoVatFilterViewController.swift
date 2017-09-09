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
    
    @IBOutlet weak var vSort: UIView!
    @IBOutlet weak var vCategory: UIView!
    @IBOutlet weak var vState: UIView!
    @IBOutlet weak var vPrice: UIView!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lbCurrentSlider: UILabel!
    
    
    var data: AdvCategoryResponse!
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //show dialog for set weight
        return false;
    }
    
    let ddSort = DropDown()
    let ddCategory = DropDown()
    let ddState = DropDown()
    let ddPrice = DropDown()
    override func bindToViewModel() {
        ddSort.anchorView = tfSort
        ddSort.dataSource = ["Tin mới nhất", "Giá cao nhất", "Giá thấp nhất", "Giảm giá", "Giảm giá", "Gần tôi nhất"]
        ddSort.width = 180
        ddSort.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfSort.text = item
        }
        
        
        //get danh muc from main
        
        ddCategory.anchorView = tfCategory
        ddCategory.dataSource = ["Tất cả"] + data.subCategory!.map{ $0.name! }
        ddCategory.width = 180
        ddCategory.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfCategory.text = item
        }
        
        ddState.anchorView = tfState
        ddState.dataSource = ["Hàng mới 100%", "Hàng sang tay", "Đã qua sử dụng"]
        ddState.width = 180
        ddState.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfState.text = item
        }
        
        ddPrice.anchorView = tfPrice
        ddPrice.dataSource = ["< 1.000.000 VND", "< 5.000.000 VND", "< 10.000.000 VND", "< 15.000.000 VND", "< 20.000.000 VND"]
        ddPrice.width = 180
        ddPrice.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfPrice.text = item
        }
        
        vSort.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSort)))
        vCategory.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCategory)))
        vState.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onState)))
        vPrice.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPrice)))
        
        
        resetFilter()
    }
    
    func collectData() -> FilterRequest {
        let sort = ddSort.indexForSelectedRow! + 1
        var category = 0
        if ddCategory.indexForSelectedRow! > 0 {
            category = data.subCategory![ddCategory.indexForSelectedRow!-1].id!
        }
        var maxPrice = 1000000
        if ddPrice.indexForSelectedRow! > 0 {
            maxPrice = (ddPrice.indexForSelectedRow! + 1) * 5000000
        }
        let type = ddState.indexForSelectedRow! + 1
        let distance = Int(slider.value * 10000)
        return FilterRequest(sort: sort, category: category, maxPrice: maxPrice, type: type, distance: distance)
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
        lbCurrentSlider.text = "\(Int(slider.value * 10000)) km"
    }
    @IBAction func onSearch(_ sender: Any) {
        RaoVatCategoryViewController.shared.filterRequest = collectData()
        RaoVatCoordinator.sharedInstance.navigation?.popViewController()
    }
    @IBAction func onResetFilter(_ sender: Any) {
        resetFilter()
        
        RaoVatCategoryViewController.shared.filterRequest = collectData()
        RaoVatCoordinator.sharedInstance.navigation?.popViewController()
    }
    
    func resetFilter(){
        ddSort.selectRow(at: 0)
        tfSort.text = ddSort.dataSource[0]
        ddCategory.selectRow(at: 0)
        tfCategory.text = ddCategory.dataSource[0]
        ddState.selectRow(at: 0)
        tfState.text = ddState.dataSource[0]
        ddPrice.selectRow(at: 0)
        tfPrice.text = ddPrice.dataSource[0]
    }
}

