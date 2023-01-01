//
//  ServerServiceAPI.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/23.
//
import Moya

enum ServerServiceAPI{
    case jwt(_ accessToken: String, _ authProvider: String)
}

extension ServerServiceAPI: TargetType {
    var baseURL: URL { URL(string: "https://oauth-test-web.onrender.com/jwt/%7Bjwt")! }
    var path: String {
        switch self {
        case .jwt:
            return "/oauth/signin"
        }
    }
    var method: Moya.Method {
        switch self {
        case .jwt:
            return .post//
        }
    }
    var task: Task {
        switch self {
        case .jwt:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
            switch self {
            case .jwt(let accessToken, let authProvider):
                let _ = accessToken
                let _ = authProvider
                
                return Data(
                    """
                    {
                        "success" : true,
                        "response" : {
                                        "jwt": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJSdW5uaW5nLWhpIiwiaWQiOjEsImV4cCI6MTY3MTc2NjczNH0._B6ObzE6QmhQlHBEwGVmaHQQQyBx_GqgXAsGYkaUreeGZt6OJOgxw4rQkY10zVoa6DqfDU8JSL_A4J6M_aeOzg"
                                        },
                        "error": {
                                    "message": "t",
                                    "status": 200
                                }
                    }
                    """.utf8)
            }
        }
    
}
