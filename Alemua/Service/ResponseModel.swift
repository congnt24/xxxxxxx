//
//  ResponseModel.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/5/17.
//  Copyright © 2017 cong. All rights reserved.
//

import SwiftyJSON


class NotifyData {
    private struct SerializationKeys {
        static let content = "content"
        static let orderId = "order_id"
        static let updatedAt = "updated_at"
        static let id = "id"
        static let isShipper = "is_shipper"
        static let numberUnread = "number_unread"
        static let createdAt = "created_at"
        static let isRead = "is_read"
        static let photo = "photo"
        static let userId = "user_id"
        static let notificationType = "notification_type"
        static let viewedList = "viewed_list"
    }
    
    // MARK: Properties
    public var content: String?
    public var orderId: Int?
    public var updatedAt: String?
    public var id: Int?
    public var isShipper: Int?
    public var numberUnread: Int?
    public var createdAt: String?
    public var isRead: Int?
    public var photo: String?
    public var userId: Int?
    public var notificationType: Int?
    public var viewedList: String?
    
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
        content = json[SerializationKeys.content].string
        orderId = json[SerializationKeys.orderId].int
        updatedAt = json[SerializationKeys.updatedAt].string
        id = json[SerializationKeys.id].int
        isShipper = json[SerializationKeys.isShipper].int
        numberUnread = json[SerializationKeys.numberUnread].int
        createdAt = json[SerializationKeys.createdAt].string
        isRead = json[SerializationKeys.isRead].int
        photo = json[SerializationKeys.photo].string
        userId = json[SerializationKeys.userId].int
        notificationType = json[SerializationKeys.notificationType].int
        viewedList = json[SerializationKeys.viewedList].string
    }

}

class CurrencyData {
    private struct SerializationKeys {
        static let name = "name"
        static let conversion = "conversion"
        static let updatedAt = "updated_at"
        static let id = "id"
        static let photo = "photo"
        static let descriptionValue = "description"
        static let createdAt = "created_at"
    }
    
    // MARK: Properties
    public var name: String?
    public var conversion: String?
    public var updatedAt: String?
    public var id: Int?
    public var photo: String?
    public var descriptionValue: String?
    public var createdAt: String?
    
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
        conversion = json[SerializationKeys.conversion].string
        updatedAt = json[SerializationKeys.updatedAt].string
        id = json[SerializationKeys.id].int
        photo = json[SerializationKeys.photo].string
        descriptionValue = json[SerializationKeys.descriptionValue].string
        createdAt = json[SerializationKeys.createdAt].string
    }
}
class CommentData {
    private struct SerializationKeys {
        static let photo = "photo"
        static let name = "name"
        static let rating = "rating"
        static let shipperComment = "shipper_comment"
        static let id = "id"
        static let createdAt = "created_at"
    }
    
    // MARK: Properties
    public var photo: String?
    public var name: String?
    public var rating: Float?
    public var shipperComment: String?
    public var id: Int?
    public var createdAt: String?
    
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
        photo = json[SerializationKeys.photo].string
        name = json[SerializationKeys.name].string
        rating = json[SerializationKeys.rating].float
        shipperComment = json[SerializationKeys.shipperComment].string
        id = json[SerializationKeys.id].int
        createdAt = json[SerializationKeys.createdAt].string
    }

}

class ClientResponse {
    private struct SerializationKeys {
        static let name = "name"
        static let rating = "rating"
        static let id = "id"
        static let numberProduct = "number_product"
        static let photo = "photo"
    }
    
    // MARK: Properties
    public var name: String?
    public var rating: Float?
    public var id: Int?
    public var numberProduct: Int?
    public var photo: String?
    
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
        rating = json[SerializationKeys.rating].float
        id = json[SerializationKeys.id].int
        numberProduct = json[SerializationKeys.numberProduct].int
        photo = json[SerializationKeys.photo].string
    }

}
