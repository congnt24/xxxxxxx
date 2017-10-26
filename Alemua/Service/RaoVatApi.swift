//
//  RaoVatApi.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//
import Foundation
import Moya


public class RaoVatService {
    public static var shared: RaoVatService!
    let api = RxMoyaProvider<RaoVatApi>(endpointClosure: endpointClosure2, manager: DefaultAlamofireManager.sharedManager, plugins: [NetworkLoggerPlugin()])
    init() {
        RaoVatService.shared = self
    }
}

public enum RaoVatApi {
    case login(phone_number: String, password: String)
    case getAllAdvCategory()
    case createAdv(advRequest: AdvRequest)
    case updateAdv(advRequest: AdvRequest)
    case getAllAdv(adv_type: Int, category_id: Int?, latitude: Float, longitude: Float, page_number: Int, text_search: String?)
    case getAdvDetails(adv_detail_id: Int, latitude: Float?, longitude: Float?)
    case addFavorite(adv_detail_id: Int)
    case getRelatedAdvs(sub_category_id: Int, page_number: Int)
    
    case increaseView(adv_detail_id: Int)
    case filterAdv(filterRequest: FilterRequest, lat: Float?, lon: Float?, page_number: Int)
    case getAllComments(adv_detail_id: Int, page_number: Int)
    case addComment(adv_detail_id: Int, comment_id: Int, content: String)
    case deleteAdv(adv_detail_id: Int)
    case reportAdv(adv_detail_id: Int)
}

extension RaoVatApi: TargetType {
    
    
    public var path: String {
        switch self {
        case .login:
            return "/api/users/login"
        case .getAllAdvCategory():
            return "/api/adv/getAllAdvCategory"
        case .createAdv:
            return "/api/adv/createAdv"
        case .updateAdv:
            return "/api/adv/updateAdv"
        case .getAllAdv:
            return "/api/adv/getAllAdv"
        case .getAdvDetails:
            return "/api/adv/getAdvDetails"
        case .addFavorite:
            return "/api/adv/addFavorite"
        case .getRelatedAdvs:
            return "/api/adv/getRelatedAdvs"
        case .filterAdv:
            return "/api/adv/filterAdv"
        case .increaseView:
            return "/api/adv/increaseView"
        case .getAllComments:
            return "/api/adv/getAllComments"
        case .addComment:
            return "/api/adv/addComment"
        case .deleteAdv:
            return "/api/adv/deleteAdv"
        case .reportAdv:
            return "/api/adv/reportAdv"
        }
    }

    
    public /// The parameters to be encoded in the request.
    var parameters: [String: Any]? {
        switch self {
        case .createAdv(let advRequest), .updateAdv(let advRequest):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["title"] = advRequest.title ?? ""
            params["photo"] = advRequest.photo ?? ""
            params["description"] = advRequest.descriptionValue ?? ""
            params["category_id"] = advRequest.categoryId ?? 0
            params["sub_category_id"] = advRequest.subCategoryId ?? 0
            params["product_type"] = advRequest.productType ?? 0
            params["price"] = advRequest.price ?? 0
            params["promotion"] = advRequest.promotion ?? 0
            params["transaction_address"] = advRequest.transactionAddress ?? ""
            params["end_date"] = advRequest.endDate ?? ""
            params["longitude"] = advRequest.longitude ?? 0
            params["latitude"] = advRequest.latitude ?? 0
            params["adv_detail_id"] = advRequest.adv_detail_id
            return params
        case .getAllAdv(let adv_type, let category_id, let latitude, let longitude, let page_number, let text_search):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["adv_type"] = adv_type
            params["category_id"] = category_id
            params["latitude"] = latitude
            params["longitude"] = longitude
            params["page_number"] = page_number
            params["page_size"] = 20
            params["text_search"] = text_search
            return params
        case .getAdvDetails(let adv_detail_id,let latitude, let longitude):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["adv_detail_id"] = adv_detail_id
            params["latitude"] = latitude ?? 0
            params["longitude"] = longitude ?? 0
            return params
        case .addFavorite(let adv_detail_id), .deleteAdv(let adv_detail_id), .reportAdv(let adv_detail_id):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["adv_detail_id"] = adv_detail_id
            return params
        case .getRelatedAdvs(let sub_category_id, let page_number):
            var params = [String: Any]()
            params["page_number"] = page_number
            params["page_size"] = 20
            params["sub_category_id"] = sub_category_id
            return params
        case .increaseView(let adv_detail_id):
            var params = [String: Any]()
            params["adv_detail_id"] = adv_detail_id
            return params
        case .getAllComments(let adv_detail_id, let page_number):
            var params = [String: Any]()
            params["page_number"] = page_number
            params["page_size"] = 20
            params["adv_detail_id"] = adv_detail_id
            return params
            
        case .filterAdv(let data, let lat, let lon, let page_number):
            var params = [String: Any]()
            params["id_sort"] = data.sort
            params["sub_category_id"] = data.category
            params["product_type"] = data.type
            params["max_price"] = data.maxPrice
            params["min_distance"] = 0
            params["max_distance"] = data.distance
            params["longitude"] = lon ?? 0
            params["latitude"] = lat ?? 0
            params["page_size"] = 20
            params["page_number"] = page_number
            return params
        case .addComment(let adv_detail_id, let comment_id, let content):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["adv_detail_id"] = adv_detail_id
            params["comment_id"] = comment_id
            params["content"] = content
            return params
        default:
            return nil
        }
    }

    public /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .createAdv, .updateAdv, .addFavorite, .increaseView, .addComment, .deleteAdv:
            return .post
        default:
            return .get
        }
    }

    public /// Provides stub data for use in testing.
    var sampleData: Data {
        switch self {
        case .login:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        default:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        }
    }

    public /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }

    public /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }


    public var baseURL: URL {
        return URL(string: "http://188.166.243.25/alemua/public/")!
    }
}

public var endpointClosure2 = { (target: RaoVatApi) -> Endpoint<RaoVatApi> in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let endpoint: Endpoint<RaoVatApi> = Endpoint(url: url, sampleResponseClosure: { .networkResponse(200, target.sampleData) }, method: target.method, parameters: target.parameters)
    print(target.parameters)
    return endpoint
}
