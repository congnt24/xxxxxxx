//
//  RaoVatMapViewController.swift
//  Alemua
//
//  Created by Cong Nguyen on 9/3/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import AwesomeMVVM

class RaoVatMapViewController: BaseViewController{
    
    var data: ProductResponse?
    var mapVc: MapViewController!
    
    override func bindToViewModel() {
        
        
        if let product = data {
            mapVc.movingCameraToLocation(lat: product.latitude ?? 21, lon: product.longitude ?? 105.81)
            mapVc.addMarkerToLocation(lat: product.latitude ?? 21, lon: product.longitude ?? 105.81, image: nil)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.mapVc = segue.destination as! MapViewController
    }
    
}
