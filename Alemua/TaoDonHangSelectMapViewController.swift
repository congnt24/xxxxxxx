//
//  TaoDonHangSelectMapViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 9/9/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import AwesomeMVVM
import RxSwift

class TaoDonHangSelectMapViewController: BaseViewController{
    public static var lat: Float?
    public static var lon: Float?
    var mapVc: MapViewController!
    let bag = DisposeBag()
    
    @IBOutlet weak var tfSearch: AwesomeTextField!
    override func bindToViewModel() {
        mapVc.onMovingMap = { result, location in
            self.tfSearch.text = result
            TaoDonHang2ViewController.shared.tfGiaoDen.text = result
            TaoDonHangSelectMapViewController.lat = Float(location?.latitude ?? 21.0)
            TaoDonHangSelectMapViewController.lon = Float(location?.longitude ?? 105.81)
        }
        
        tfSearch.rx.controlEvent(UIControlEvents.editingDidEnd).subscribe(onNext: {
            if let search = self.tfSearch.text {
                self.mapVc.searchlocation(locSearch: search)
            }
        }).addDisposableTo(bag)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.mapVc = segue.destination as! MapViewController
    }
    
}
