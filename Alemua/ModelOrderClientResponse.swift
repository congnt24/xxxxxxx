//
//  ModelOrderClientResponse.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/3/17.
//  Copyright © 2017 cong. All rights reserved.
//

import SwiftyJSON

class ModelOrderClientResponse: BaseModelResponse<ModelOrderClientData> {
    
}

public class ModelOrderClientData: BaseResult {
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
        static let deliveryDate = "delivery_date"
        static let quotes = "quotes"
        static let cancelReason = "cancel_reason"
        static let totalPrice = "total_price"
        static let transaction_alemua_free = "transaction_alemua_free"
//        static let buying_price = "buying_price"
        
    }
    
    // MARK: Properties
    public var productOption: String?
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
    public var deliveryDate: String?
    public var cancelReason: String?
    public var quotes: [ModelOrderBaoGiaData]?
    public var totalPrice: Int?
    public var transaction_alemua_free: Int?
//    public var buying_price: Int?
    
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
        productOption = json[SerializationKeys.productOption].string
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
        deliveryDate = json[SerializationKeys.deliveryDate].string
        cancelReason = json[SerializationKeys.cancelReason].string
        totalPrice = json[SerializationKeys.totalPrice].int
        transaction_alemua_free = json[SerializationKeys.transaction_alemua_free].int
//        buying_price = json[SerializationKeys.buying_price].int
        if let items = json[SerializationKeys.quotes].array { quotes = items.map { ModelOrderBaoGiaData(json: $0) } }

    }
}

public class ModelOrderBaoGiaData {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let deliveryDate = "delivery_date"
        static let note = "note"
        static let buyFrom = "buy_from"
        static let updatedAt = "updated_at"
        static let orderId = "order_id"
        static let userPostId = "user_post_id"
        static let timeAgo = "time_ago"
        static let buyingPrice = "buying_price"
        static let discount = "discount"
        static let transferToBuyerFee = "transfer_to_buyer_fee"
        static let totalPrice = "total_price"
        static let rating = "rating"
        static let descriptionValue = "description"
        static let tax = "tax"
        static let transferDomesticFee = "transfer_domestic_fee"
        static let id = "id"
        static let deliveryTo = "delivery_to"
        static let createdAt = "created_at"
        static let userPhoto = "user_photo"
        static let userPost = "user_post"
        static let transferBuyerFee = "transfer_buyer_fee"
        static let transferAlemuaFree = "transfer_alemua_free"
        static let transactionAlemuaFree = "transaction_alemua_free"
        static let promotion_money = "promotion_money"
    }
    
    // MARK: Properties
    public var deliveryDate: String?
    public var note: String?
    public var buyFrom: String?
    public var updatedAt: String?
    public var orderId: Int?
    public var userPostId: Int?
    public var timeAgo: Int?
    public var buyingPrice: Int?
    public var discount: Int?
    public var transferToBuyerFee: Int?
    public var totalPrice: Int?
    public var rating: Float?
    public var descriptionValue: String?
    public var tax: Int?
    public var transferDomesticFee: Int?
    public var id: Int?
    public var deliveryTo: String?
    public var createdAt: String?
    public var userPhoto: String?
    public var userPost: String?
    public var transferBuyerFee: Int?
    public var transferAlemuaFree: Int?
    public var transactionAlemuaFree: Int?
    public var promotion_money: Int?
    
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
        deliveryDate = json[SerializationKeys.deliveryDate].string
        note = json[SerializationKeys.note].string
        buyFrom = json[SerializationKeys.buyFrom].string
        updatedAt = json[SerializationKeys.updatedAt].string
        orderId = json[SerializationKeys.orderId].int
        userPostId = json[SerializationKeys.userPostId].int
        timeAgo = json[SerializationKeys.timeAgo].int
        buyingPrice = json[SerializationKeys.buyingPrice].int
        discount = json[SerializationKeys.discount].int
        transferToBuyerFee = json[SerializationKeys.transferToBuyerFee].int
        totalPrice = json[SerializationKeys.totalPrice].int
        rating = json[SerializationKeys.rating].float
        descriptionValue = json[SerializationKeys.descriptionValue].string
        tax = json[SerializationKeys.tax].int
        transferDomesticFee = json[SerializationKeys.transferDomesticFee].int
        id = json[SerializationKeys.id].int
        deliveryTo = json[SerializationKeys.deliveryTo].string
        createdAt = json[SerializationKeys.createdAt].string
        userPhoto = json[SerializationKeys.userPhoto].string
        userPost = json[SerializationKeys.userPost].string
        transferBuyerFee = json[SerializationKeys.transferBuyerFee].int
        transferAlemuaFree = json[SerializationKeys.transferAlemuaFree].int
        transactionAlemuaFree = json[SerializationKeys.transactionAlemuaFree].int
        promotion_money = json[SerializationKeys.promotion_money].int
    }

}



