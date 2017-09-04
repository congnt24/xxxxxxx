//
// Created by Cong Nguyen on 8/8/17.
// Copyright (c) 2017 cong. All rights reserved.
//

import Foundation
import SwiftyJSON

class ConversationUserData {
    private struct SerializationKeys {
        static let name = "name"
        static let updatedAt = "updated_at"
        static let email = "email"
        static let rememberToken = "remember_token"
        static let address = "address"
        static let descriptionValue = "description"
        static let isSuspend = "is_suspend"
        static let phoneNumber = "phone_number"
        static let deviceType = "device_type"
        static let isNotify = "is_notify"
        static let tokenFirebase = "token_firebase"
        static let isAdmin = "is_admin"
        static let id = "id"
        static let photo = "photo"
        static let createdAt = "created_at"
        static let introduceCode = "introduce_code"
        static let last_message = "last_message"
        static let last_time = "last_time"
    }

    // MARK: Properties
    public var name: String?
    public var updatedAt: String?
    public var email: String?
    public var rememberToken: String?
    public var address: String?
    public var descriptionValue: String?
    public var isSuspend: Int?
    public var phoneNumber: String?
    public var deviceType: Int?
    public var isNotify: Int?
    public var tokenFirebase: String?
    public var isAdmin: Int?
    public var id: Int?
    public var photo: String?
    public var createdAt: String?
    public var introduceCode: String?
    public var last_message: String?
    public var last_time: String?

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
        name = json[SerializationKeys.name].string
        updatedAt = json[SerializationKeys.updatedAt].string
        email = json[SerializationKeys.email].string
        rememberToken = json[SerializationKeys.rememberToken].string
        address = json[SerializationKeys.address].string
        descriptionValue = json[SerializationKeys.descriptionValue].string
        isSuspend = json[SerializationKeys.isSuspend].int
        phoneNumber = json[SerializationKeys.phoneNumber].string
        deviceType = json[SerializationKeys.deviceType].int
        isNotify = json[SerializationKeys.isNotify].int
        tokenFirebase = json[SerializationKeys.tokenFirebase].string
        isAdmin = json[SerializationKeys.isAdmin].int
        id = json[SerializationKeys.id].int
        photo = json[SerializationKeys.photo].string
        createdAt = json[SerializationKeys.createdAt].string
        introduceCode = json[SerializationKeys.introduceCode].string
        last_message = json[SerializationKeys.last_message].string
        last_time = json[SerializationKeys.last_time].string
    }
}
