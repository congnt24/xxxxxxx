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
import SearchTextField

class RaoVatSelectMapViewController: BaseViewController{
    
    var mapVc: MapViewController!
    let bag = DisposeBag()
    
    @IBOutlet weak var tfSearch: SearchTextField!
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
        
        //Audo suggest map
        tfSearch.theme.bgColor = UIColor.white
        tfSearch.rx.value
            .filter { $0 != nil && $0 != "" }//.throttle(300, latest: true, scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { (str) in
                print("asdasdasd \(str)")
                PlaceService.shared.api.request(PlaceApi.queryByName(query: str ?? ""))
                    .toJSONPlace()
                    .subscribe(onNext: { (res) in
                        switch res {
                        case .done(let result, _):
                            if let res = result.array {
                                let filterString = res.map { PlaceData(description: $0["description"].string ?? "") }.map { $0.description }
                                self.tfSearch.filterStrings(filterString)
                            }
                            break
                        case .error(let msg):
                            print("Error \(msg)")
                            break
                        }
                    }).addDisposableTo(self.bag)
            })
        tfSearch.itemSelectionHandler = { filteredResults, itemPosition in
            self.tfSearch.text = filteredResults[itemPosition].title
            self.mapVc.searchlocation(locSearch: self.tfSearch.text!)
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
