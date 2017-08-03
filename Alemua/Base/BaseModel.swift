//
//  BaseModel.swift
//  Alemua
//
//  Created by Cong Nguyen on 8/1/17.
//  Copyright © 2017 cong. All rights reserved.
//


import SwiftyJSON

open class BaseModelResponse<T: BaseResult> {
    public var result: [T]?
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
        if let items = json["result"].array { result = items.map { T(json: $0) } }
        code = json["code"].int
        message = json["message"].string
    }
    
}

open class BaseResult {
    public required init(json: JSON) {
    }
}
