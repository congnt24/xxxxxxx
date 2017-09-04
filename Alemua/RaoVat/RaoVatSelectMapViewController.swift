//
//  RaoVatMapViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 9/3/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import AwesomeMVVM

class RaoVatSelectMapViewController: BaseViewController{
    
    var mapVc: MapViewController!
    
    @IBOutlet weak var tfSearch: AwesomeTextField!
    override func bindToViewModel() {
        mapVc.onMovingMap = { result, location in
            self.tfSearch.text = result
            RaoVatPublishViewController.shared.tfAddress.text = result
            RaoVatPublishViewController.shared.selectedLat = location?.latitude ?? 21.0
            RaoVatPublishViewController.shared.selectedLon = location?.longitude ?? 105.81
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.mapVc = segue.destination as! MapViewController
    }
    
}
