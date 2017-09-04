//
//  RaoVatMapViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 9/3/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import AwesomeMVVM
import RxSwift

class RaoVatSelectMapViewController: BaseViewController{
    
    var mapVc: MapViewController!
    let bag = DisposeBag()
    
    @IBOutlet weak var tfSearch: AwesomeTextField!
    override func bindToViewModel() {
        mapVc.onMovingMap = { result, location in
            self.tfSearch.text = result
            RaoVatPublishViewController.shared.tfAddress.text = result
            RaoVatPublishViewController.shared.selectedLat = location?.latitude ?? 21.0
            RaoVatPublishViewController.shared.selectedLon = location?.longitude ?? 105.81
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
