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

let GitHubProvider = RxMoyaProvider<GitHub>(endpointClosure: endpointClosure)

public enum GitHub {
    case login(username: String, password: String)
    case register(username: String, password: String)
    case getProfile(username: String)
    case updateProfile(username: String)
}

extension GitHub: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    public var path: String {
        switch self {
        case .login(let username, let password):
            return "/authorizations"
        case .register(let username, let password):
            return "/authorizations"
        case .getProfile(let username):
            return "/authorizations"
        case .updateProfile(let username):
            return "/authorizations"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login(_, _), .register(_, _), .updateProfile(_):
            return .post
        case .getProfile(_):
            return .get
        }
    }

    public var parameters: [String: Any]? {
        switch self {
        case .login(let username, let password):
            return [
                "scopes": ["public_repo", "user"],
                "note": "Ori iOS app (\(Date()))"
            ]
        case .updateProfile(_):
            return nil

        case .register(_, _), .getProfile(_):
            return nil
        }
    }
    public /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }

    public /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    public /// Provides stub data for use in testing.
    var sampleData: Data {
        switch self {
        case .login(_, _):
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        default:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        }
    }


}

public var endpointClosure = { (target: GitHub) -> Endpoint<GitHub> in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let endpoint: Endpoint<GitHub> = Endpoint(url: url, sampleResponseClosure: { .networkResponse(200, target.sampleData) }, method: target.method, parameters: target.parameters)
    switch target {
    case .login(let userString, let passwordString):
        let credentialData = "\(userString):\(passwordString)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        return endpoint.adding(newHTTPHeaderFields: ["Authorization": "Basic \(base64Credentials)"])
            .adding(newParameterEncoding: JSONEncoding.default)
    default:
        let appToken = Token()
        guard let token = appToken.token else {
            return endpoint
        }
        return endpoint.adding(newHTTPHeaderFields: ["Authorization": "token \(token)"])
    }
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}
