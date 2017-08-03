//
//  ModelQuoteResponse.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/2/17.
//  Copyright © 2017 cong. All rights reserved.
//

import SwiftyJSON

public class ModelQuoteResponse: BaseModelResponse<ModelQuoteData> {
    
}

public class ModelQuoteData: BaseResult {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let productOption = "product_option"
        static let note = "note"
        static let buyFrom = "buy_from"
        static let updatedAt = "updated_at"
        static let websitePrice = "website_price"
        static let numberProduct = "number_product"
        static let websiteUrl = "website_url"
        static let productName = "product_name"
        static let quantity = "quantity"
        static let orderStatus = "order_status"
        static let promotionCode = "promotion_code"
        static let isBefore = "is_before"
        static let id = "id"
        static let productDescription = "product_description"
        static let transactionOption = "transaction_option"
        static let photo = "photo"
        static let createdAt = "created_at"
        static let deliveryTo = "delivery_to"
        static let userId = "user_id"
        static let promotionMoney = "promotion_money"
        static let userPost = "user_post"
        static let numberQuote = "number_quote"
        static let deliveryDate = "delivery_date"
    }

    // MARK: Properties
    public var productOption: Int?
    public var note: String?
    public var buyFrom: String?
    public var updatedAt: String?
    public var websitePrice: Int?
    public var numberProduct: Int?
    public var websiteUrl: String?
    public var productName: String?
    public var quantity: Int?
    public var orderStatus: Int?
    public var promotionCode: String?
    public var isBefore: Int?
    public var id: Int?
    public var productDescription: String?
    public var transactionOption: Int?
    public var photo: String?
    public var createdAt: String?
    public var deliveryTo: String?
    public var userId: Int?
    public var promotionMoney: Int?
    public var userPost: String?
    public var numberQuote: Int?
    public var deliveryDate: String?

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
        productOption = json[SerializationKeys.productOption].int
        note = json[SerializationKeys.note].string
        buyFrom = json[SerializationKeys.buyFrom].string
        updatedAt = json[SerializationKeys.updatedAt].string
        websitePrice = json[SerializationKeys.websitePrice].int
        numberProduct = json[SerializationKeys.numberProduct].int
        websiteUrl = json[SerializationKeys.websiteUrl].string
        productName = json[SerializationKeys.productName].string
        quantity = json[SerializationKeys.quantity].int
        orderStatus = json[SerializationKeys.orderStatus].int
        promotionCode = json[SerializationKeys.promotionCode].string
        isBefore = json[SerializationKeys.isBefore].int
        id = json[SerializationKeys.id].int
        productDescription = json[SerializationKeys.productDescription].string
        transactionOption = json[SerializationKeys.transactionOption].int
        photo = json[SerializationKeys.photo].string
        createdAt = json[SerializationKeys.createdAt].string
        deliveryTo = json[SerializationKeys.deliveryTo].string
        userId = json[SerializationKeys.userId].int
        promotionMoney = json[SerializationKeys.promotionMoney].int
        userPost = json[SerializationKeys.userPost].string
        numberQuote = json[SerializationKeys.numberQuote].int
        deliveryDate = json[SerializationKeys.deliveryDate].string
    }
}
