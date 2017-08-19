//
//  ModelMainOrderResponse.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/1/17.
//  Copyright © 2017 cong. All rights reserved.
//

import SwiftyJSON

class ModelMainOrderResponse: BaseModelResponse<ModelOrderData> {
}

class ModelOrderData: BaseResult {
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let name = "name"
        static let promotionPercent = "promotion_percent"
        static let updatedAt = "updated_at"
        static let promotionPrice = "promotion_price"
        static let websiteUrl = "website_url"
        static let address = "address"
        static let isDiscount = "is_discount"
        static let isHot = "is_hot"
        static let categoryId = "category_id"
        static let originPrice = "origin_price"
        static let id = "id"
        static let photo = "photo"
        static let createdAt = "created_at"
        static let currencyId = "currency_id"
    }
    
    // MARK: Properties
    public var name: String?
    public var promotionPercent: Int?
    public var updatedAt: String?
    public var promotionPrice: Int?
    public var websiteUrl: String?
    public var address: String?
    public var isDiscount: Int?
    public var isHot: Int?
    public var categoryId: Int?
    public var originPrice: Int?
    public var id: Int?
    public var photo: String?
    public var createdAt: String?
    public var currencyId: Int?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        super.init(json: json)
        name = json[SerializationKeys.name].string
        promotionPercent = json[SerializationKeys.promotionPercent].int
        updatedAt = json[SerializationKeys.updatedAt].string
        promotionPrice = json[SerializationKeys.promotionPrice].int
        websiteUrl = json[SerializationKeys.websiteUrl].string
        address = json[SerializationKeys.address].string
        isDiscount = json[SerializationKeys.isDiscount].int
        isHot = json[SerializationKeys.isHot].int
        categoryId = json[SerializationKeys.categoryId].int
        originPrice = json[SerializationKeys.originPrice].int
        id = json[SerializationKeys.id].int
        photo = json[SerializationKeys.photo].string
        createdAt = json[SerializationKeys.createdAt].string
        currencyId = json[SerializationKeys.currencyId].int
    }

}
