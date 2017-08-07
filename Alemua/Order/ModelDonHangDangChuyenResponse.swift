//
//  ModelDonHangDangChuyenResponse.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/5/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ModelDonHangDangChuyenData{
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let userPostName = "user_post_name"
        static let userPostPhone = "user_post_phone"
        static let userPostPhoto = "user_post_photo"
        static let transferDomesticFee = "transfer_domestic_fee"
        static let userShipName = "user_ship_name"
        static let id = "id"
        static let photo = "photo"
        static let transferBuyerFee = "transfer_buyer_fee"
        static let transferAlemuaFree = "transfer_alemua_free"
        static let note = "note"
        static let buyFrom = "buy_from"
        static let totalPrice = "total_price"
        static let transactionAlemuaFree = "transaction_alemua_free"
        static let userPostId = "user_post_id"
        static let buyingPrice = "buying_price"
        static let descriptionValue = "description"
        static let transferToBuyerFee = "transfer_to_buyer_fee"
        static let discount = "discount"
        static let productName = "product_name"
        static let userShipPhone = "user_ship_phone"
        static let userPostRating = "user_post_rating"
        static let tax = "tax"
        static let userShipRating = "user_ship_rating"
        static let deliveryTo = "delivery_to"
        static let userShipId = "user_ship_id"
        static let userShipPhoto = "user_ship_photo"
        static let deliveryDate = "delivery_date"
    }
    
    // MARK: Properties
    public var userPostName: String?
    public var userPostPhone: String?
    public var userPostPhoto: String?
    public var transferDomesticFee: Int?
    public var userShipName: String?
    public var id: Int?
    public var photo: String?
    public var transferBuyerFee: Int?
    public var transferAlemuaFree: Int?
    public var note: String?
    public var buyFrom: String?
    public var totalPrice: Int?
    public var transactionAlemuaFree: Int?
    public var userPostId: Int?
    public var buyingPrice: Int?
    public var descriptionValue: String?
    public var transferToBuyerFee: Int?
    public var discount: Int?
    public var productName: String?
    public var userShipPhone: String?
    public var userPostRating: Float?
    public var tax: Int?
    public var userShipRating: Float?
    public var deliveryTo: String?
    public var userShipId: Int?
    public var userShipPhoto: String?
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
        userPostName = json[SerializationKeys.userPostName].string
        userPostPhone = json[SerializationKeys.userPostPhone].string
        userPostPhoto = json[SerializationKeys.userPostPhoto].string
        transferDomesticFee = json[SerializationKeys.transferDomesticFee].int
        userShipName = json[SerializationKeys.userShipName].string
        id = json[SerializationKeys.id].int
        photo = json[SerializationKeys.photo].string
        transferBuyerFee = json[SerializationKeys.transferBuyerFee].int
        transferAlemuaFree = json[SerializationKeys.transferAlemuaFree].int
        note = json[SerializationKeys.note].string
        buyFrom = json[SerializationKeys.buyFrom].string
        totalPrice = json[SerializationKeys.totalPrice].int
        transactionAlemuaFree = json[SerializationKeys.transactionAlemuaFree].int
        userPostId = json[SerializationKeys.userPostId].int
        buyingPrice = json[SerializationKeys.buyingPrice].int
        descriptionValue = json[SerializationKeys.descriptionValue].string
        transferToBuyerFee = json[SerializationKeys.transferToBuyerFee].int
        discount = json[SerializationKeys.discount].int
        productName = json[SerializationKeys.productName].string
        userShipPhone = json[SerializationKeys.userShipPhone].string
        userPostRating = json[SerializationKeys.userPostRating].float
        tax = json[SerializationKeys.tax].int
        userShipRating = json[SerializationKeys.userShipRating].float
        deliveryTo = json[SerializationKeys.deliveryTo].string
        userShipId = json[SerializationKeys.userShipId].int
        userShipPhoto = json[SerializationKeys.userShipPhoto].string
        deliveryDate = json[SerializationKeys.deliveryDate].string
    }
}
