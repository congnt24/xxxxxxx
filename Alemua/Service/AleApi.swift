//
//  AleApi.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//
import Foundation
import Moya
import RxSwift

let GitHubProvider = RxMoyaProvider<AleApi>(endpointClosure: endpointClosure)

public enum AleApi {
    case login(phone_number: String, token_firebase: String, device_type: Int)
    case createOrder()
    case createQuote()
    case acceptQuote()
    case getHomeItems()
    case getProducts(type: Int, page: Int)
}

extension AleApi: TargetType {

    public var baseURL: URL {
        return URL(string: "http://128.199.228.205/alemua/public/")!
    }

    public var path: String {
        switch self {
        case .login:
            return "/api/users/loginAndRegister"
        case .createOrder():
            return "/api/order/createOrder"
        case .createQuote():
            return "/api/order/createQuote"
        case .acceptQuote():
            return "/api/order/acceptQuote"
        case .getHomeItems():
            return "/api/order/getHomeItems"
        case .getProducts(_, _):
            return "/api/order/getProducts"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login(_, _, _), .createOrder(), .acceptQuote():
            return .post
        default:
            return .get
        }
    }

    public var parameters: [String: Any]? {
        switch self {
        case .login(let phone_number, let token_firebase, let device_type):
            return [
                "phone_number": phone_number,
                "token_firebase": token_firebase,
                "device_type": 2
            ]
        case .createOrder():
            return [
                "UserID":2,
                "ApiToken":"4fIVqGZPGQQakv7FBlyzUs671jzerg422UZrP2t4trl761Tekdngg6DSZoe8",
                "product_name":"Máy nghe nhạc MP3",
                "product_description":"Máy nghe nhạc xịn",
                "photo":"image.png,image1.png",
                "website_url":"amazon.com",
                "website_price":100,
                "promotion_code":"",
                "quantity":1,
                "product_option":3,
                "buy_from":"Mỹ",
                "delivery_to":"Hà Đông - Hà Nội",
                "delivery_date":"2017-07-28",
                "note":"Giao hàng đúng giờ",
                "transaction_option": 1
            ]
        case .createQuote():
            return [
                "UserID":3,
                "ApiToken":"gduO4eJFqR9eUnHhdKiEADIyhOBhEh6RF6qQZ5oNWhF9ySLeE4MLlGM5L4Nd",
                "order_id":2,
                "total_price":200,
                "discount":0
            ]
        case .acceptQuote():
            return [
                "UserID":2,
                "ApiToken":"4fIVqGZPGQQakv7FBlyzUs671jzerg422UZrP2t4trl761Tekdngg6DSZoe8",
                "order_id":1,
                "quote_id":1,
                "discount":0
            ]
        case .getProducts(let type, let page):
            return [
            "product_type": type,
            "page_size": 20,
            "page_number": page
            ]
        default:
            return nil
        }
    }

    public /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }

    public /// Provides stub data for use in testing.
    var sampleData: Data {
        switch self {
        case .login(_, _, _):
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        default:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        }
    }

    public /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }

}

public var endpointClosure = { (target: AleApi) -> Endpoint<AleApi> in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let endpoint: Endpoint<AleApi> = Endpoint(url: url, sampleResponseClosure: { .networkResponse(200, target.sampleData) }, method: target.method, parameters: target.parameters)
    
//    switch target {
//    case .login(let phone_number, let token, let device_type):
//        let credentialData = "\(userString):\(passwordString)".data(using: String.Encoding.utf8)!
//        let base64Credentials = credentialData.base64EncodedString(options: [])
//        return endpoint.adding(newHTTPHeaderFields: ["Authorization": "Basic \(base64Credentials)"])
//            .adding(newParameterEncoding: JSONEncoding.default)
//    default:
//        let appToken = Token()
//        guard let token = appToken.token else {
//            return endpoint
//        }
//        return endpoint.adding(newHTTPHeaderFields: ["Authorization": "token \(token)"])
//    }
     return endpoint
}

extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}
