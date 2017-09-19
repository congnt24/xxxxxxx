//
//  OrderFilterViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/29/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import AwesomeMVVM
import DropDown
import RxSwift

class DeliveryFilter2ViewController: UIViewController {
    public static var deliveryOrderFilterType = 0
    public static var shouldReload = false
    @IBOutlet weak var view1: AwesomeUIView!
    @IBOutlet weak var view2: AwesomeUIView!
    @IBOutlet weak var view3: AwesomeUIView!
    @IBOutlet weak var ddNhomHang: UIStackView!
    @IBOutlet weak var ddQuocGia: UIStackView!
    @IBOutlet weak var tfNhomHang: AwesomeTextField!
    @IBOutlet weak var tfQuocGia: AwesomeTextField!
    
    let bag = DisposeBag()
    // MARK: - Setup dropdown
    let nhomHangDr = DropDown()
    let quocGiaDr = DropDown()
    
    
    var listBranch = [Int]()
    var listCountry = [Int]()
    public static var branch = 0
    public static var country = 0
    var tmpbranch = DeliveryFilter2ViewController.branch
    var tmpcountry = DeliveryFilter2ViewController.country
    var tmpFilter = DeliveryFilter2ViewController.deliveryOrderFilterType
    
    var listChecked: [UIView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listChecked = [view1.subviews[0].subviews[2], view2.subviews[0].subviews[2], view3.subviews[0].subviews[2]]
        for check in listChecked {
            check.isHidden = true
        }
        if DeliveryFilter2ViewController.deliveryOrderFilterType >= 0 {
            listChecked[DeliveryFilter2ViewController.deliveryOrderFilterType].isHidden = false
        }
        view1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onView1)))
        view2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onView2)))
        view3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onView3)))
        
        nhomHangDr.anchorView = ddNhomHang
        nhomHangDr.dataSource = ["Tất cả"]
//        nhomHangDr.width = 180
        nhomHangDr.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfNhomHang.text = item
            self.tmpbranch = self.listBranch[index]
        }
        
        quocGiaDr.anchorView = ddQuocGia
        quocGiaDr.dataSource = ["Hàng mới 100%"]
//        quocGiaDr.width = 180
        quocGiaDr.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfQuocGia.text = item
            self.tmpcountry = self.listCountry[index]
        }
        
        fetchBranchAndCountry()
        
        ddNhomHang.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDrNhomHang)))
        ddQuocGia.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDrQuocGia)))
    }
    
    func onDrNhomHang(){
        nhomHangDr.show()
    }
    func onDrQuocGia(){
        quocGiaDr.show()
    }

    
    func onView1() {
        for check in listChecked {
            check.isHidden = true
        }
        listChecked[0].isHidden = false
        
        tmpFilter = 0
        
    }
    func onView2() {
        for check in listChecked {
            check.isHidden = true
        }
        listChecked[1].isHidden = false
        tmpFilter = 1
        
    }
    func onView3() {
        for check in listChecked {
            check.isHidden = true
        }
        listChecked[2].isHidden = false
        tmpFilter = 2
    }
    
    @IBAction func onFilter(_ sender: Any) {
        DeliveryFilter2ViewController.deliveryOrderFilterType = tmpFilter
        DeliveryFilter2ViewController.branch = tmpbranch
        DeliveryFilter2ViewController.country = tmpcountry
        DeliveryFilter2ViewController.shouldReload = true
        DeliveryCoordinator.sharedInstance.navigation?.popViewController()
    }
    
    
    func fetchBranchAndCountry(){
        AlemuaApi.shared.aleApi.request(AleApi.getAllBrand())
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    if let arr = result.array {
                        self.nhomHangDr.dataSource = arr.map { $0["name"].string ?? "" }
                        self.listBranch = arr.map { $0["id"].int ?? 0 }
                        let x = self.listBranch.index(of: DeliveryFilter2ViewController.branch)
                        self.nhomHangDr.selectRow(at: x)
                        self.tfNhomHang.text = self.nhomHangDr.selectedItem
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
        AlemuaApi.shared.aleApi.request(AleApi.getAllCountry())
            .toJSON()
            .subscribe(onNext: { (res) in
                switch res {
                case .done(let result, _):
                    if let arr = result.array {
                        self.quocGiaDr.dataSource = arr.map { $0["name"].string ?? "" }
                        self.listCountry = arr.map { $0["id"].int ?? 0 }
                        let x = self.listCountry.index(of: DeliveryFilter2ViewController.country)
                        self.quocGiaDr.selectRow(at: x)
                        self.tfQuocGia.text = self.quocGiaDr.selectedItem
                    }
                    break
                case .error(let msg):
                    print("Error \(msg)")
                    break
                }
            }).addDisposableTo(bag)
    }

}
