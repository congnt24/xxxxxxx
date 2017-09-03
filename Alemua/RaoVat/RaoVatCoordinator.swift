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
    func showRaoVatCategory(data: AdvCategoryResponse) {
        let view: RaoVatCategoryViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatCategoryViewController.self)
            view.data = data
        navigation?.pushViewController(view, animated: true)
    }
    func showRaoVatDetail(data: ProductResponse) {
        let view: RaoVatDetailViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatDetailViewController.self)
        view.data = data
        navigation?.pushViewController(view, animated: true)
    }
    func showRaoVatPublish(data: Any) {
        let view: RaoVatPublishViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatPublishViewController.self)
        //        data = data
        navigation?.pushViewController(view, animated: true)
    }
    func showRaoVatPublishForEdit(data: ProductResponse) {
        let view: RaoVatPublishViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatPublishViewController.self)
            view.data = data
        navigation?.pushViewController(view, animated: true)
    }
    func showRaoVatComment(data: ProductDetailResponse) {
        let view: RaoVatCommentViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatCommentViewController.self)
            view.data = data
        navigation?.pushViewController(view, animated: true)
    }

    func showRaoVatReplyComment(data: CommentResponse, advDetail: ProductDetailResponse) {
        let view: RaoVatReplyCommentViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatReplyCommentViewController.self)
            view.data = data
            view.advDetail = advDetail
        navigation?.pushViewController(view, animated: true)
    }
    func showRaoVatProfile(data: Any) {
        let view: RaoVatProfileViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatProfileViewController.self)
        //        data = data
        navigation?.pushViewController(view, animated: true)
    }
    func showRaoVatListAction(data: ActionType) {
        let view: RaoVatProfileListActionViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatProfileListActionViewController.self)
        view.actionType = data
        navigation?.pushViewController(view, animated: true)
    }
    func showRaoVatFilter(data: AdvCategoryResponse) {
        let view: RaoVatFilterViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatFilterViewController.self)
                view.data = data
        navigation?.pushViewController(view, animated: true)
    }
    func showRaoVatMenu(data: Any) {
        let view: RaoVatMenuViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatMenuViewController.self)
        //        data = data
        navigation?.pushViewController(view, animated: true)
    }
    
    
    func showMapViewController(data: ProductResponse){
        let view: RaoVatMapViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatMapViewController.self)
        view.data = data
        navigation?.pushViewController(view, animated: true)
    }
    
    func showSearchViewController(){
        let view: RaoVatSearchViewController = getBaoGiaStoryboard().instantiateViewController(withClass: RaoVatSearchViewController.self)
//        view.data = data
        navigation?.pushViewController(view, animated: true)
    }
}
