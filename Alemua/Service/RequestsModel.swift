//
//  RequestsModel.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/4/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation

public class TaoDonHangRequest {
    public var productOption: Int?
    public var note: String?
    public var buyFrom: String?
    public var websitePrice: Int?
    public var deliveryDate: String?
    public var websiteUrl: String?
    public var quantity: Int?
    public var productName: String?
    public var promotionCode: String?
    public var productDescription: String?
    public var deliveryTo: String?
    public var transactionOption: Int?
    public var userID: Int?
    public var photo: String?
    public var apiToken: String?
    public var isBefore: Int?
    public var numberProduct: Int?

    public func validateStep1() -> Bool {
        if existNil(strs: [websitePrice, websiteUrl, quantity, productName
                    , productDescription]) {
            return false
        }
        return true
    }

    public func validateStep2() -> Bool {
        if existNil(strs: [buyFrom, deliveryDate, deliveryTo]) {
            return false
        }
        return true
    }

    public func validate() -> Bool {
        if existNil(strs: [buyFrom, "\(websitePrice!)", deliveryDate, websiteUrl, "\(quantity!)", productName
                    , productDescription, deliveryTo, "\(transactionOption!)"]) {
            return false
        }
        return true
    }
}

public class CreateQuoteRequest {
    // MARK: CreateQuoteRequest Properties
    public var apiToken: String?
    public var note: String?
    public var totalPrice: Int?
    public var orderId: Int?
    public var buyFrom: String?
    public var deliveryDate: String?
    public var discount: Int?
    public var descriptionValue: String?
    public var transferToBuyerFee: Int?
    public var buyingPrice: Int?
    public var transferDomesticFee: Int?
    public var tax: Int?
    public var deliveryTo: String?
    public var userID: Int?
    public var transferBuyerFee: Int?
    public var transferAlemuaFree: Int?
}

public class AcceptQuoteRequest {
    // MARK: AcceptQuoteRequest Properties
    public var transactionOption: Int?
    public var userID: Int?
    public var orderId: Int?
    public var quoteId: Int?
    public var apiToken: String?
}

public class CancelOrderRequest {
    // MARK: CancelOrderRequest Properties
    public var apiToken: String?
    public var orderId: Int?
    public var cancelReason: String?
    public var userID: Int?
}

public class ReportUserRequest {
    // MARK: ReportUserRequest Properties
    public var userReport: Int?
    public var apiToken: String?
    public var reportContent: String?
    public var userID: Int?
}

public class RateForClient {
    // MARK: RateForClient Properties
    public var userAttitudeRating: Int?
    public var userPaymentRating: Int?
    public var ratingId: Int?
    public var userID: Int?
    public var apiToken: String?
}

public class UpdateProfileRequest {
    // MARK: UpdateProfileRequest Properties
    public var apiToken: String?
    public var name: String?
    public var email: String?
    public var userID: Int?
    public var address: String?
    public var descriptionValue: String?
    public var photo: String?
    public var profileType: Int?
    public var isNotify: Int?
}


public class DeliveredOrderData {
    private struct SerializationKeys {
        static let orderId = "order_id"
        static let shipperAttitudeRating = "shipper_attitude_rating"
        static let shipperComment = "shipper_comment"
        static let photo = "photo"
        static let shipperPaymentRating = "shipper_payment_rating"
        static let userID = "UserID"
        static let shipperTimeRating = "shipper_time_rating"
        static let apiToken = "ApiToken"
    }
    
    // MARK: Properties
    public var orderId: Int?
    public var shipperAttitudeRating: Int?
    public var shipperComment: String?
    public var photo: String?
    public var shipperPaymentRating: Int?
    public var userID: Int?
    public var shipperTimeRating: Int?
    public var apiToken: String?
    
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
        orderId = json[SerializationKeys.orderId].int
        shipperAttitudeRating = json[SerializationKeys.shipperAttitudeRating].int
        shipperComment = json[SerializationKeys.shipperComment].string
        photo = json[SerializationKeys.photo].string
        shipperPaymentRating = json[SerializationKeys.shipperPaymentRating].int
        userID = json[SerializationKeys.userID].int
        shipperTimeRating = json[SerializationKeys.shipperTimeRating].int
        apiToken = json[SerializationKeys.apiToken].string
    }

}







