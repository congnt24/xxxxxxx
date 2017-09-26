//
//  AleApi.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//
import Foundation
import Moya


public class AlemuaApi {
    public static var shared: AlemuaApi!
    let aleApi = RxMoyaProvider<AleApi>(endpointClosure: endpointClosure, manager: DefaultAlamofireManager.sharedManager, plugins: [NetworkLoggerPlugin()])
    init() {
        AlemuaApi.shared = self
    }
}

public enum AleApi {
    case login(phone_number: String, password: String)
    case createOrder(data: TaoDonHangRequest)
    case createQuote(quote: CreateQuoteRequest)
    case acceptQuote(data: AcceptQuoteRequest)
    case getHomeItems(page: Int?, filter_type: Int)
    case getProducts(type: Int, page: Int)
    case uploadFile(photos: [UIImage])
    case getQuoteForShipper(page_number: Int, text_search: String, sort_type: Int, brand_id: Int, country_id: Int)
    case getOrderFromClient(page_number: Int, order_type: Int, sort_type: Int)//order_type = 0-4
    case getOrderFromShipper(page_number: Int, order_type: Int, sort_type: Int)//order_type=1
    case cancelOrder(data: CancelOrderRequest)
    case reportUser(data: ReportUserRequest)
    case rateForClient(data: RateForClient)
    case getOrderDetailsToQuote(order_id: Int)
    case getOrderDetails(orderType: Int, orderId: Int)
    case getCommentOfShipper(shipperId: Int, page_number: Int)
    case getUserProfile(profileType: Int) //1,2
    case getListClients()
    case updateProfile(data: UpdateProfileRequest)
    //    =1: Cập nhật bật tắt Notification (Chỉ cần truyền lên trường is_notify)
    //    =2: Cập nhật các thông tin còn lại (Không cần truyền lên trường is_notify)
    case setDeliveredOrder(data: DeliveredOrderData)
    case getListUsersToChat()
    case addChattingLog(user_receive_id: Int)
    case activeAccount(phone_number: String, password: String)
    case getDataFromUrl(website_url: String)
    case logout()
    case getAllCurrency()
    case loginAndRegisterFacebook(data: FacebookRequest)
    case getNotifications(page_number: Int, is_shipper: Int)
    case readNotification(notification_id: Int)
    case getUnreadNotification(isShipper: Int)
    case getTransferMoney(order_id: Int?, weight: Float?)
    case getAllBrand()
    case getAllCountry()
    case getAllMoney()
}

extension AleApi: TargetType {

    public var baseURL: URL {
        return URL(string: "http://128.199.228.205/alemua/public/")!
    }

    public var path: String {
        switch self {
        case .login:
            return "/api/users/login"
        case .createOrder(_):
            return "/api/order/createOrder"
        case .createQuote(_):
            return "/api/order/createQuote"
        case .acceptQuote(_):
            return "/api/order/acceptQuote"
        case .getHomeItems:
            return "/api/order/getHomeItems"
        case .getProducts(_, _):
            return "/api/order/getProducts"
        case .uploadFile(_):
            return "/api/users/uploadFile"
        case .getQuoteForShipper:
            return "/api/order/getQuoteForShipper"
        case .getOrderFromClient:
            return "/api/order/getOrderFromClient"
        case .getOrderFromShipper:
            return "/api/order/getOrderFromShipper"
        case .cancelOrder(_):
            return "/api/order/cancelOrder"
        case .reportUser(_):
            return "/api/order/reportUser"
        case .rateForClient(_):
            return "/api/order/rateForClient"
        case .getOrderDetailsToQuote(_):
            return "/api/order/getOrderDetailsToQuote"
        case .getOrderDetails(_, _):
            return "/api/order/getOrderDetails"
        case .getCommentOfShipper(_, _):
            return "/api/order/getCommentOfShipper"
        case .getUserProfile(_):
            return "/api/users/getUserProfile"
        case .getListClients():
            return "/api/users/getListClients"
        case .updateProfile(_):
            return "/api/users/updateProfile"
        case .setDeliveredOrder(_):
            return "/api/order/setDeliveredOrder"
        case .getListUsersToChat():
            return "/api/users/getListUsersToChat"
        case .addChattingLog(_):
            return "/api/users/addChattingLog"
        case .activeAccount(_, _):
            return "/api/users/activeAccount"
        case .getDataFromUrl(_):
            return "/api/order/getDataFromUrl"
        case .logout():
            return "/api/users/logout"
        case .getAllCurrency():
            return "/api/order/getAllCurrency"
        case .loginAndRegisterFacebook:
            return "/api/users/loginAndRegisterFacebook"
        case .getNotifications:
            return "/api/order/getNotifications"
        case .readNotification:
            return "/api/order/readNotification"
        case .getUnreadNotification:
            return "/api/order/getUnreadNotification"
        case .getTransferMoney:
            return "/api/order/getTransferMoney"
        case .getAllBrand:
            return "/api/users/getAllBrand"
        case .getAllCountry:
            return "/api/users/getAllCountry"
        case .getAllMoney:
            return "/api/users/getAllMoney"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login, .createOrder(_), .createQuote(_), .acceptQuote(_), .reportUser(_), .cancelOrder(_), .rateForClient(_), .uploadFile(_), .updateProfile, .setDeliveredOrder(_)
             , .logout(), .activeAccount(_, _), .addChattingLog(_), .loginAndRegisterFacebook, .readNotification(_):
            return .post
        default:
            return .get
        }
    }

    public var parameters: [String: Any]? {
        switch self {
        case .login(let phone_number, let password):
            var params = [String: Any]()
            params["phone_number"] = phone_number
            params["password"] = password
            params["token_firebase"] = Prefs.firebaseToken
            params["device_type"] = 2
            return params
        case .createOrder(let data):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["product_name"] = data.productName ?? ""
            params["product_description"] = data.productDescription ?? ""
            params["buy_from"] = data.buyFrom ?? ""
            params["delivery_to"] = data.deliveryTo ?? ""
            params["delivery_date"] = data.deliveryDate ?? ""
            params["note"] = data.note ?? ""
            params["website_url"] = data.websiteUrl ?? ""
            params["website_price"] = data.websitePrice ?? 0
            params["promotion_code"] = data.promotionCode ?? ""
            params["transaction_option"] = data.transactionOption ?? 1
            params["quantity"] = data.quantity ?? 1
            params["photo"] = data.photo ?? ""
            params["product_option"] = data.productOption ?? 0
            params["is_before"] = data.isBefore ?? 0
            params["number_product"] = data.numberProduct ?? 1
            params["currency_id"] = data.currencyId ?? 1
            params["website_real_price"] = data.websiteRealPrice ?? 1
            params["latitude"] = data.latitude
            params["longitude"] = data.longitude
            params["brand_id"] = data.brand_id
            params["country_id"] = data.country_id
            return params
        case .createQuote(let quote):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["order_id"] = quote.orderId!
            params["buy_from"] = quote.buyFrom!
            params["delivery_to"] = quote.deliveryTo!
            params["delivery_date"] = quote.deliveryDate!
            params["description"] = quote.descriptionValue!
            params["note"] = quote.note!
            params["total_price"] = quote.totalPrice!
            params["buying_price"] = quote.buyingPrice ?? 0
            params["discount"] = quote.discount ?? 0
            params["tax"] = quote.tax ?? 0
            params["transfer_domestic_fee"] = quote.transferDomesticFee ?? 0
            params["transfer_buyer_fee"] = quote.transferBuyerFee ?? 0
            params["transfer_alemua_free"] = quote.transferAlemuaFree ?? 0
            params["transfer_to_buyer_fee"] = quote.transferToBuyerFee ?? 0
            params["transaction_alemua_free"] = quote.transactionAlemuaFree ?? 0
            params["promotion_money"] = quote.promotion_money ?? 0
            params["weight"] = quote.weight ?? 0
            params["promotion_code"] = quote.promotion_code ?? 0
            params["website_price"] = quote.website_price ?? 0
            return params
        case .acceptQuote(let data):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["order_id"] = data.orderId!
            params["quote_id"] = data.quoteId!
            params["transaction_option"] = data.transactionOption!
            return params
        case .cancelOrder(let data):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["order_id"] = data.orderId!
            params["cancel_reason"] = data.cancelReason!
            return params
        case .reportUser(let data):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["user_report"] = data.userReport!
            params["report_content"] = data.reportContent!
            return params
        case .rateForClient(let data):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["rating_id"] = data.ratingId
            params["user_attitude_rating"] = data.userAttitudeRating ?? 0
            params["user_payment_rating"] = data.userPaymentRating ?? 0
            return params
        case .getProducts(let type, let page):
            var params = [String: Any]()
            params["product_type"] = type
            params["page_size"] = 20
            params["page_number"] = page
            return params
        case .getQuoteForShipper(let page_number, let text_search, let sort_type, let brand_id, let country_id):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["page_size"] = 20
            params["page_number"] = page_number
            params["text_search"] = text_search
            params["sort_type"] = sort_type
            params["brand_id"] = brand_id
            params["country_id"] = country_id
            return params
        case .getOrderFromClient(let page_number, let order_type, let sort_type):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["page_size"] = 20
            params["page_number"] = page_number
            params["order_type"] = order_type
            params["sort_type"] = sort_type
            return params
        case .getOrderFromShipper(let page_number, let order_type, let sort_type):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiTokenShipper
            params["page_size"] = 20
            params["page_number"] = page_number
            params["order_type"] = order_type
            params["sort_type"] = sort_type
            return params
        case .getOrderDetailsToQuote(let order_id):
            var params = [String: Any]()
            params["order_id"] = order_id
            return params

        case .getOrderDetails(let orderType, let orderId):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["order_type"] = orderType
            params["order_id"] = orderId
            return params
        case .getCommentOfShipper(let shipperId, let page_number):
            var params = [String: Any]()
            params["UserID"] = shipperId
            params["page_size"] = 20
            params["page_number"] = page_number
            return params
        case .getListClients():
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            return params

        case .getUserProfile(let profile_type):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["profile_type"] = profile_type//1 = client, 2 = shipper
            return params
        case .updateProfile(let data):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["address"] = data.address ?? ""
            params["description"] = data.descriptionValue ?? ""
            params["email"] = data.email ?? ""
            params["photo"] = data.photo ?? ""
            params["profile_type"] = data.profileType ?? 2
            params["is_notify"] = data.isNotify ?? 0
            params["name"] = data.name ?? ""
            params["phone_number"] = data.phoneNumber ?? ""
            return params
        case .uploadFile(_):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            return params
        case .setDeliveredOrder(let data):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["order_id"] = data.orderId
            params["shipper_time_rating"] = data.shipperTimeRating ?? 0
            params["shipper_attitude_rating"] = data.shipperAttitudeRating ?? 0
            params["shipper_payment_rating"] = data.shipperPaymentRating ?? 0
            params["shipper_comment"] = data.shipperComment ?? ""
            params["photo"] = data.photo ?? ""
            return params
        case .getListUsersToChat:
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            return params
        case .addChattingLog(let user_receive_id):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["user_receive_id"] = user_receive_id
            return params
        case .activeAccount(let phone_number, let password):
            var params = [String: Any]()
            params["phone_number"] = phone_number
            params["password"] = password
            return params
        case .getDataFromUrl(let website_url):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["website_url"] = website_url
            return params
        case .logout():
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            return params
        case .getHomeItems(let page, let filter_type):
            var params = [String: Any]()
            params["page_size"] = 20
            params["page_number"] = page ?? 1
            params["filter_type"] = filter_type
            return params
        case .getAllCurrency():
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            return params
        case .loginAndRegisterFacebook(let data):
            var params = [String: Any]()
            params["email"] = data.email
            params["device_type"] = 2
            params["token_firebase"] = data.tokenFirebase
            params["facebook_id"] = data.facebookId
            params["phone_number"] = data.phoneNumber
            params["photo"] = data.photo
            params["name"] = data.name
            return params
            
        case .getNotifications(let page_number, let is_shipper):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["page_size"] = 20
            params["page_number"] = page_number
            params["is_shipper"] = is_shipper
            return params
        case .readNotification(let notification_id):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["notification_id"] = notification_id
            return params
        case .getUnreadNotification(let is_shipper):
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            params["is_shipper"] = is_shipper
            return params
        case .getTransferMoney(let order_id, let weight):
            var params = [String: Any]()
            params["order_id"] = order_id
            params["weight"] = weight
            return params
            
        case .getAllMoney():
            var params = [String: Any]()
            params["UserID"] = Prefs.userId
            params["ApiToken"] = Prefs.apiToken
            return params
            
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
        case .login:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        default:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        }
    }

    public /// The type of HTTP task to be performed.
    var task: Task {
        switch self {
        case .uploadFile(let photos):
            var formData = [MultipartFormData]()
            for i in 1...photos.count {
                let imageData = UIImageJPEGRepresentation(photos[i - 1], 1.0)
                formData.append(MultipartFormData(provider: .data(imageData!), name: "FileNo\(i)", fileName: "photo.jpg", mimeType: "image/jpeg"))
            }
            return .upload(.multipart(formData))
        default:
            return .request
        }
    }

}

public var endpointClosure = { (target: AleApi) -> Endpoint<AleApi> in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let endpoint: Endpoint<AleApi> = Endpoint(url: url, sampleResponseClosure: { .networkResponse(200, target.sampleData) }, method: target.method, parameters: target.parameters)
    print(target.parameters)

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
