//
//  RaoVatResponse.swift
//  Alemua
//
//  Created by Cong Nguyen on 9/1/17.
//  Copyright © 2017 cong. All rights reserved.
//

import Foundation
import SwiftyJSON

class AdvCategoryResponse {
    private struct SerializationKeys {
        static let photo = "photo"
        static let name = "name"
        static let subCategory = "sub_category"
        static let updatedAt = "updated_at"
        static let id = "id"
        static let createdAt = "created_at"
    }
    public var photo: String?
    public var name: String?
    public var subCategory: [SubCategory]?
    public var updatedAt: String?
    public var id: Int?
    public var createdAt: String?
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    public required init(json: JSON) {
        photo = json[SerializationKeys.photo].string
        name = json[SerializationKeys.name].string
        if let items = json[SerializationKeys.subCategory].array { subCategory = items.map { SubCategory(json: $0) } }
        updatedAt = json[SerializationKeys.updatedAt].string
        id = json[SerializationKeys.id].int
        createdAt = json[SerializationKeys.createdAt].string
    }
}

public class SubCategory {
    private struct SerializationKeys {
        static let name = "name"
        static let categoryId = "category_id"
        static let updatedAt = "updated_at"
        static let id = "id"
        static let createdAt = "created_at"
    }
    public var name: String?
    public var categoryId: Int?
    public var updatedAt: String?
    public var id: Int?
    public var createdAt: String?
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    public required init(json: JSON) {
        name = json[SerializationKeys.name].string
        categoryId = json[SerializationKeys.categoryId].int
        updatedAt = json[SerializationKeys.updatedAt].string
        id = json[SerializationKeys.id].int
        createdAt = json[SerializationKeys.createdAt].string
    }
}



public class ProductDetailResponse {
    private struct SerializationKeys {
        static let userAddress = "user_address"
        static let categoryId = "category_id"
        static let subCategoryId = "sub_category_id"
        static let latitude = "latitude"
        static let id = "id"
        static let photo = "photo"
        static let distance = "distance"
        static let title = "title"
        static let longitude = "longitude"
        static let endDate = "end_date"
        static let productType = "product_type"
        static let numberViewed = "number_viewed"
        static let timeAgo = "time_ago"
        static let updatedAt = "updated_at"
        static let isLike = "is_like"
        static let descriptionValue = "description"
        static let transactionAddress = "transaction_address"
        static let userPhoneNumber = "user_phone_number"
        static let price = "price"
        static let createdAt = "created_at"
        static let isSafe = "is_safe"
        static let promotion = "promotion"
        static let userId = "user_id"
        static let userPhoto = "user_photo"
        static let userName = "user_name"
    }

    // MARK: Properties
    public var userAddress: String?
    public var categoryId: Int?
    public var subCategoryId: Int?
    public var latitude: Int?
    public var id: Int?
    public var photo: String?
    public var distance: Int?
    public var title: String?
    public var longitude: Int?
    public var endDate: String?
    public var productType: Int?
    public var numberViewed: Int?
    public var timeAgo: Int?
    public var updatedAt: String?
    public var isLike: Int?
    public var descriptionValue: String?
    public var transactionAddress: String?
    public var userPhoneNumber: String?
    public var price: Int?
    public var createdAt: String?
    public var isSafe: Int?
    public var promotion: Int?
    public var userId: Int?
    public var userPhoto: String?
    public var userName: String?

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
        userAddress = json[SerializationKeys.userAddress].string
        categoryId = json[SerializationKeys.categoryId].int
        subCategoryId = json[SerializationKeys.subCategoryId].int
        latitude = json[SerializationKeys.latitude].int
        id = json[SerializationKeys.id].int
        photo = json[SerializationKeys.photo].string
        distance = json[SerializationKeys.distance].int
        title = json[SerializationKeys.title].string
        longitude = json[SerializationKeys.longitude].int
        endDate = json[SerializationKeys.endDate].string
        productType = json[SerializationKeys.productType].int
        numberViewed = json[SerializationKeys.numberViewed].int
        timeAgo = json[SerializationKeys.timeAgo].int
        updatedAt = json[SerializationKeys.updatedAt].string
        isLike = json[SerializationKeys.isLike].int
        descriptionValue = json[SerializationKeys.descriptionValue].string
        transactionAddress = json[SerializationKeys.transactionAddress].string
        userPhoneNumber = json[SerializationKeys.userPhoneNumber].string
        price = json[SerializationKeys.price].int
        createdAt = json[SerializationKeys.createdAt].string
        isSafe = json[SerializationKeys.isSafe].int
        promotion = json[SerializationKeys.promotion].int
        userId = json[SerializationKeys.userId].int
        userPhoto = json[SerializationKeys.userPhoto].string
        userName = json[SerializationKeys.userName].string
    }
}

public class ProductResponse {
    private struct SerializationKeys {
        static let numberViewed = "number_viewed"
        static let timeAgo = "time_ago"
        static let updatedAt = "updated_at"
        static let transactionAddress = "transaction_address"
        static let descriptionValue = "description"
        static let categoryId = "category_id"
        static let price = "price"
        static let subCategoryId = "sub_category_id"
        static let latitude = "latitude"
        static let id = "id"
        static let distance = "distance"
        static let createdAt = "created_at"
        static let photo = "photo"
        static let promotion = "promotion"
        static let title = "title"
        static let userId = "user_id"
        static let longitude = "longitude"
        static let endDate = "end_date"
        static let productType = "product_type"
    }

    public var numberViewed: Int?
    public var timeAgo: Int?
    public var updatedAt: String?
    public var transactionAddress: String?
    public var descriptionValue: String?
    public var categoryId: Int?
    public var price: Int?
    public var subCategoryId: Int?
    public var latitude: Float?
    public var id: Int?
    public var distance: Int?
    public var createdAt: String?
    public var photo: String?
    public var promotion: Int?
    public var title: String?
    public var userId: Int?
    public var longitude: Float?
    public var endDate: String?
    public var productType: Int?

    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    public required init(json: JSON) {
        numberViewed = json[SerializationKeys.numberViewed].int
        timeAgo = json[SerializationKeys.timeAgo].int
        updatedAt = json[SerializationKeys.updatedAt].string
        transactionAddress = json[SerializationKeys.transactionAddress].string
        descriptionValue = json[SerializationKeys.descriptionValue].string
        categoryId = json[SerializationKeys.categoryId].int
        price = json[SerializationKeys.price].int
        subCategoryId = json[SerializationKeys.subCategoryId].int
        latitude = json[SerializationKeys.latitude].float
        id = json[SerializationKeys.id].int
        distance = json[SerializationKeys.distance].int
        createdAt = json[SerializationKeys.createdAt].string
        photo = json[SerializationKeys.photo].string
        promotion = json[SerializationKeys.promotion].int
        title = json[SerializationKeys.title].string
        userId = json[SerializationKeys.userId].int
        longitude = json[SerializationKeys.longitude].float
        endDate = json[SerializationKeys.endDate].string
        productType = json[SerializationKeys.productType].int
    }

}

public class CommentResponse {
    private struct SerializationKeys {
        static let content = "content"
        static let subComment = "sub_comment"
        static let timeAgo = "time_ago"
        static let updatedAt = "updated_at"
        static let id = "id"
        static let advDetailId = "adv_detail_id"
        static let isMain = "is_main"
        static let createdAt = "created_at"
        static let commentId = "comment_id"
        static let userId = "user_id"
        static let userName = "user_name"
        static let userPhoto = "user_photo"
    }

    public var content: String?
    public var subComment: [CommentResponse]?
    public var timeAgo: Int?
    public var updatedAt: String?
    public var id: Int?
    public var advDetailId: Int?
    public var isMain: Int?
    public var createdAt: String?
    public var commentId: Int?
    public var userId: Int?
    public var userName: String?
    public var userPhoto: String?

    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }

    public required init(json: JSON) {
        content = json[SerializationKeys.content].string
        if let items = json[SerializationKeys.subComment].array { subComment = items.map { CommentResponse(json: $0) } }
        timeAgo = json[SerializationKeys.timeAgo].int
        updatedAt = json[SerializationKeys.updatedAt].string
        id = json[SerializationKeys.id].int
        advDetailId = json[SerializationKeys.advDetailId].int
        isMain = json[SerializationKeys.isMain].int
        createdAt = json[SerializationKeys.createdAt].string
        commentId = json[SerializationKeys.commentId].int
        userId = json[SerializationKeys.userId].int
        userName = json[SerializationKeys.userName].string
        userPhoto = json[SerializationKeys.userPhoto].string
    }
    
    init() {
        
    }
}
public class SubComment {
    private struct SerializationKeys {
        static let content = "content"
        static let timeAgo = "time_ago"
        static let updatedAt = "updated_at"
        static let advDetailId = "adv_detail_id"
        static let id = "id"
        static let isMain = "is_main"
        static let commentId = "comment_id"
        static let createdAt = "created_at"
        static let userId = "user_id"
        static let userName = "user_name"
        static let userPhoto = "user_photo"
    }

    // MARK: Properties
    public var content: String?
    public var timeAgo: Int?
    public var updatedAt: String?
    public var advDetailId: Int?
    public var id: Int?
    public var isMain: Int?
    public var commentId: Int?
    public var createdAt: String?
    public var userId: Int?
    public var userName: String?
    public var userPhoto: String?

    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }

    public required init(json: JSON) {
        content = json[SerializationKeys.content].string
        timeAgo = json[SerializationKeys.timeAgo].int
        updatedAt = json[SerializationKeys.updatedAt].string
        advDetailId = json[SerializationKeys.advDetailId].int
        id = json[SerializationKeys.id].int
        isMain = json[SerializationKeys.isMain].int
        commentId = json[SerializationKeys.commentId].int
        createdAt = json[SerializationKeys.createdAt].string
        userId = json[SerializationKeys.userId].int
        userName = json[SerializationKeys.userName].string
        userPhoto = json[SerializationKeys.userPhoto].string
    }
}







