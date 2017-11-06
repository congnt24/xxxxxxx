//
//  CheckinApi.swift
//  CheckIniOS
//
//  Created by Cong Nguyen on 8/17/17.
//  Copyright © 2017 Cong Nguyen. All rights reserved.
//

import Foundation
import Moya

public class PlaceService {
    public static var shared: PlaceService!
    let api = RxMoyaProvider<PlaceApi>(endpointClosure: endpointClosure3, plugins: [NetworkLoggerPlugin()])
    init() {
        PlaceService.shared = self
    }
}

public enum PlaceApi {
    case queryByName(query: String)
}

extension PlaceApi: TargetType {
    public /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }
    
    public var baseURL: URL {
        return URL(string: "https://maps.googleapis.com/maps/api/place/")!
    }
    
    public var path: String {
        switch self {
        case .queryByName:
            return "autocomplete/json"
        }
    }
    
    public var method: Moya.Method {
        
        return .get
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .queryByName(let query):
            var params = [String: Any]()
            params["input"] = query
            params["key"] = "AIzaSyBYZFWStzxJ4icSpb7yVj1Ox7k3LLnRYsE"
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
        case .queryByName:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        default:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        }
    }
    
}

public var endpointClosure3 = { (target: PlaceApi) -> Endpoint<PlaceApi> in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let endpoint: Endpoint<PlaceApi> = Endpoint(url: url, sampleResponseClosure: { .networkResponse(200, target.sampleData) }, method: target.method, parameters: target.parameters)
    print(target.parameters)
    return endpoint
}

