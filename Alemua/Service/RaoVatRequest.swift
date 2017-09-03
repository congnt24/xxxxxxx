//
//  RaoVatRequest.swift
//  Alemua
//
//  Created by Cong Nguyen on 9/1/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation

public class AdvRequest {
    public var latitude: Float?
    public var price: Int?
    public var subCategoryId: Int?
    public var photo: String?
    public var transactionAddress: String?
    public var descriptionValue: String?
    public var promotion: Int?
    public var categoryId: Int?
    public var title: String?
    public var longitude: Float?
    public var productType: Int?
    public var endDate: String?
    public var adv_detail_id: Int?

}

public struct FilterRequest {
    public var sort: Int?
    public var category: Int?
    public var maxPrice: Int?
    public var type: Int?
    public var distance: Int?
}
