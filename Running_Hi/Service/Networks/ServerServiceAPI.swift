//
//  ServerServiceAPI.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/23.
//
import Moya

enum ServerServiceAPI{
    case fetchJwt(_ accessToken: String, _ authProvider: String)
}

extension ServerServiceAPI: TargetType {
    var baseURL: URL { URL(string: "https://oauth-test-web.onrender.com/jwt/%7Bjwt")! }
    var path: String {
        switch self {
        case .fetchJwt:
            return "/oauth/signin"
        }
    }
    var method: Moya.Method {
        switch self {
        case .fetchJwt:
            return .post//
        }
    }
    var task: Task {
        switch self {
        case .fetchJwt:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
