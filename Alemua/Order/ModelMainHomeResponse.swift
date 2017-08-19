//
//  ModelMainHomeResponse.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/1/17.
//  Copyright © 2017 cong. All rights reserved.
//

import SwiftyJSON

class ModelMainHomeResponse{
    public var result: ModelMainHomeData?
    public var code: Int?
    public var message: String?
    
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
        result = ModelMainHomeData(json: json["result"])
        code = json["code"].int
        message = json["message"].string
    }

}
struct ModelBuyingOnline{
    var items: [ModelBuyingOnlineItem]?
}

class ModelMainHomeData: BaseResult {
    private struct SerializationKeys {
        static let buyingOnlineItem = "buying_online_item"
        static let hotProducts = "hot_products"
    }
    
    
    // MARK: Properties
    public var buyingOnlineItem: [ModelBuyingOnlineItem]?
    public var hotProducts: [ModelOrderData]?
    
    
    required init(json: JSON) {
        super.init(json: json)
        if let items = json[SerializationKeys.hotProducts].array {
            print(items)
            hotProducts = items.map { ModelOrderData(json: $0) }
        }
//        if let items = json[SerializationKeys.discountProducts].array { discountProducts = items.map { ModelOrderData(json: $0) } }
        if let items = json[SerializationKeys.buyingOnlineItem].array { buyingOnlineItem = items.map { ModelBuyingOnlineItem(json: $0) } }
    }
}


public class ModelBuyingOnlineItem {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let descriptionValue = "description"
        static let createdAt = "created_at"
        static let updatedAt = "updated_at"
        static let id = "id"
        static let websiteUrl = "website_url"
        static let photo = "photo"
    }
    
    // MARK: Properties
    public var descriptionValue: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var id: Int?
    public var websiteUrl: String?
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
        descriptionValue = json[SerializationKeys.descriptionValue].string
        createdAt = json[SerializationKeys.createdAt].string
        updatedAt = json[SerializationKeys.updatedAt].string
        id = json[SerializationKeys.id].int
        websiteUrl = json[SerializationKeys.websiteUrl].string
        photo = json[SerializationKeys.photo].string
    }
}
