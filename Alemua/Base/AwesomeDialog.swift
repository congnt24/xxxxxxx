//
//  AwesomeDialog.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/23/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit

open class AwesomeDialog {
    public class var shared: AwesomeDialog {
        struct Static {
            static let instance: AwesomeDialog = AwesomeDialog()
        }
        return Static.instance
    }
    public func show(vc: UIViewController!, name: String = "Main", identify: String!) {
        show(vc: vc, popupVC: UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identify))
    }
    
    public func show(vc: UIViewController!, popupVC: UIViewController!) {popupVC.modalPresentationStyle = .popover
        //        popupVC.preferredContentSize = CGSize(300, 300)
        //        let pVC = popupVC.popoverPresentationController
        //        pVC?.permittedArrowDirections = .any
        //        pVC?.delegate = self
        ////        pVC?.sourceView = sender
        //        pVC?.sourceRect = CGRect(x: 100, y: 100, width: 1, height: 1)
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.view.backgroundColor = UIColor.init(hexString: "111111", transparency: 0.5)
        vc.present(popupVC, animated: true, completion: nil)
    }

    
}
