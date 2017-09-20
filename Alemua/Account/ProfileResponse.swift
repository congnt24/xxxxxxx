//
//  ProfileData.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/5/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProfileData {
    private struct SerializationKeys {
        static let apiToken = "ApiToken"
        static let name = "name"
        static let updatedAt = "updated_at"
        static let phoneNumber = "phone_number"
        static let rating = "rating"
        static let numberDone = "number_done"
        static let deviceType = "device_type"
        static let isNotify = "is_notify"
        static let tokenFirebase = "token_firebase"
        static let id = "id"
        static let numberCancelled = "number_cancelled"
        static let createdAt = "created_at"
        static let photo = "photo"
        static let introduceCode = "introduce_code"
        static let numberInProgress = "number_in_progress"
        static let email = "email"
        static let address = "address"
        static let description = "description"
        static let numberOrder = "number_order"
        static let numberUser = "number_user"
        static let totalMoney = "total_money"
        static let is_safe = "is_safe"
        static let transaction_alemua = "transaction_alemua"
        static let transaction_myself = "transaction_myself"
        static let income = "income"
        static let number_order_in_time = "number_order_in_time"
        static let number_order_slow_time = "number_order_slow_time"
        static let number_order_cancelled = "number_order_cancelled"
    }
    
    // MARK: Properties
    public var apiToken: String?
    public var name: String?
    public var updatedAt: String?
    public var phoneNumber: String?
    public var rating: Float?
    public var numberDone: Int?
    public var deviceType: Int?
    public var isNotify: Int?
    public var tokenFirebase: String?
    public var id: Int?
    public var numberCancelled: Int?
    public var createdAt: String?
    public var photo: String?
    public var introduceCode: String?
    public var numberInProgress: Int?
    public var email: String?
    public var address: String?
    public var description: String?
    public var numberOrder: Int?
    public var numberUser: Int?
    public var totalMoney: Int?
    public var is_safe: Int?
    public var transaction_alemua: Int?
    public var transaction_myself: Int?
    public var income: Int?
    public var number_order_in_time: Int?
    public var number_order_slow_time: Int?
    public var number_order_cancelled: Int?
    
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
        apiToken = json[SerializationKeys.apiToken].string
        name = json[SerializationKeys.name].string
        updatedAt = json[SerializationKeys.updatedAt].string
        phoneNumber = json[SerializationKeys.phoneNumber].string
        rating = json[SerializationKeys.rating].float
        numberDone = json[SerializationKeys.numberDone].int
        deviceType = json[SerializationKeys.deviceType].int
        isNotify = json[SerializationKeys.isNotify].int
        tokenFirebase = json[SerializationKeys.tokenFirebase].string
        id = json[SerializationKeys.id].int
        numberCancelled = json[SerializationKeys.numberCancelled].int
        createdAt = json[SerializationKeys.createdAt].string
        photo = json[SerializationKeys.photo].string
        introduceCode = json[SerializationKeys.introduceCode].string
        numberInProgress = json[SerializationKeys.numberInProgress].int
        email = json[SerializationKeys.email].string
        address = json[SerializationKeys.address].string
        description = json[SerializationKeys.description].string
        numberOrder = json[SerializationKeys.numberOrder].int
        numberUser = json[SerializationKeys.numberUser].int
        totalMoney = json[SerializationKeys.totalMoney].int
        is_safe = json[SerializationKeys.is_safe].int
        transaction_alemua = json[SerializationKeys.transaction_alemua].int
        transaction_myself = json[SerializationKeys.transaction_myself].int
        income = json[SerializationKeys.income].int
        number_order_in_time = json[SerializationKeys.number_order_in_time].int
        number_order_slow_time = json[SerializationKeys.number_order_slow_time].int
        number_order_cancelled = json[SerializationKeys.number_order_cancelled].int
    }

}

//class ProfileDataShipper {
//    private struct SerializationKeys {
//        static let apiToken = "ApiToken"
//        static let name = "name"
//        static let updatedAt = "updated_at"
//        static let phoneNumber = "phone_number"
//        static let rating = "rating"
//        static let deviceType = "device_type"
//        static let isNotify = "is_notify"
//        static let tokenFirebase = "token_firebase"
//        static let id = "id"
//        static let createdAt = "created_at"
//        static let photo = "photo"
//        static let introduceCode = "introduce_code"
//        static let email = "email"
//        static let address = "address"
//        static let description = "description"
//        static let numberOrder = "number_order"
//        static let numberUser = "number_user"
//        static let totalMoney = "total_money"
//    }
//    
//    // MARK: Properties
//    public var apiToken: String?
//    public var name: String?
//    public var updatedAt: String?
//    public var phoneNumber: String?
//    public var rating: Int?
//    public var deviceType: Int?
//    public var isNotify: Int?
//    public var tokenFirebase: String?
//    public var id: Int?
//    public var createdAt: String?
//    public var photo: String?
//    public var introduceCode: String?
//    public var email: String?
//    public var address: String?
//    public var description: String?
//    public var numberOrder: Int?
//    public var numberUser: Int?
//    public var totalMoney: Int?
//    
//    // MARK: SwiftyJSON Initializers
//    /// Initiates the instance based on the object.
//    ///
//    /// - parameter object: The object of either Dictionary or Array kind that was passed.
//    /// - returns: An initialized instance of the class.
//    public convenience init(object: Any) {
//        self.init(json: JSON(object))
//    }
//    
//    /// Initiates the instance based on the JSON that was passed.
//    ///
//    /// - parameter json: JSON object from SwiftyJSON.
//    public required init(json: JSON) {
//        apiToken = json[SerializationKeys.apiToken].string
//        name = json[SerializationKeys.name].string
//        updatedAt = json[SerializationKeys.updatedAt].string
//        phoneNumber = json[SerializationKeys.phoneNumber].string
//        rating = json[SerializationKeys.rating].int
//        deviceType = json[SerializationKeys.deviceType].int
//        isNotify = json[SerializationKeys.isNotify].int
//        tokenFirebase = json[SerializationKeys.tokenFirebase].string
//        id = json[SerializationKeys.id].int
//        createdAt = json[SerializationKeys.createdAt].string
//        photo = json[SerializationKeys.photo].string
//        introduceCode = json[SerializationKeys.introduceCode].string
//        email = json[SerializationKeys.email].string
//        address = json[SerializationKeys.address].string
//        description = json[SerializationKeys.description].string
//        numberOrder = json[SerializationKeys.numberOrder].int
//        numberUser = json[SerializationKeys.numberUser].int
//        totalMoney = json[SerializationKeys.totalMoney].int
//    }
//
//}
