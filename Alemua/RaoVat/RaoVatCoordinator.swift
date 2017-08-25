//
//  BaoGiaCoordinator.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/25/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import UIKit
import AwesomeMVVM

class RaoVatCoordinator: Coordinator {
    public static var sharedInstance: RaoVatCoordinator!
    override func start(_ data: Any?) {
        RaoVatCoordinator.sharedInstance = self
        let view: RaoVatViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatViewController.self)
        navigation?.pushViewController(view, animated: true)
    }
}

extension RaoVatCoordinator {
    func showRaoVatCategory(data: Any) {
        let view: RaoVatCategoryViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatCategoryViewController.self)
        //        data = data
        navigation?.pushViewController(view, animated: true)
    }
    func showRaoVatDetail(data: Any) {
        let view: RaoVatDetailViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatDetailViewController.self)
        //        data = data
        navigation?.pushViewController(view, animated: true)
    }
    func showRaoVatPublish(data: Any) {
        let view: RaoVatPublishViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatPublishViewController.self)
        //        data = data
        navigation?.pushViewController(view, animated: true)
    }
    func showRaoVatComment(data: Any) {
        let view: RaoVatCommentViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatCommentViewController.self)
        //        data = data
        navigation?.pushViewController(view, animated: true)
    }

    func showRaoVatReplyComment(data: Any) {
        let view: RaoVatReplyCommentViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatReplyCommentViewController.self)
        //        data = data
        navigation?.pushViewController(view, animated: true)
    }
    func showRaoVatProfile(data: Any) {
        let view: RaoVatProfileViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatProfileViewController.self)
        //        data = data
        navigation?.pushViewController(view, animated: true)
    }
    func showRaoVatListAction(data: Any) {
        let view: RaoVatProfileListActionViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatProfileListActionViewController.self)
        //        data = data
        navigation?.pushViewController(view, animated: true)
    }
    func showRaoVatFilter(data: Any) {
        let view: RaoVatFilterViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatFilterViewController.self)
        //        data = data
        navigation?.pushViewController(view, animated: true)
    }
}
