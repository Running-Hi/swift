//
//  ServerServiceAPI.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/23.
//
import Moya

enum ServerServiceAPI{
    case kakaoJwt(_ accessToken: String)
    case signUp(_ user: User, _ accessToken: String, _ jwtAccessToken: String)
}

extension ServerServiceAPI: TargetType {
    var baseURL: URL { URL(string: "http://localhost:8080")! }
    var path: String {
        switch self {
        case .kakaoJwt:
            return "/oauth/signin/kakao"
        case .signUp:
            return "/signup/kakao"
        }
    }
    var method: Moya.Method {
        switch self {
        case .kakaoJwt, .signUp:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .kakaoJwt(let accessToken):
            var params: [String: Any] = [:]
            params["access_token"] = accessToken
            let paramsJson = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
            return .requestData(paramsJson)
        case .signUp(let user, let accessToken, _):
            var params: [String: Any] = [:]
            params["id"] = user.id
            params["gender"] = user.gender
            params["age"] = user.age
            params["nickname"] = user.nickName
            params["access_token"] = accessToken
            let paramsJson = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
            return .requestData(paramsJson)
        }
    }
    var headers: [String: String]? {
        switch self{
        case .signUp(_, _, let jwtAccessToken):
            let header = [
                "Authorization": "bearer \(jwtAccessToken)",
                "Content-type": "application/json"
            ]
            return header
        case .kakaoJwt(_):
            return ["Content-type": "application/json"]
        }
        
    }
    
//    var sampleData: Data {
//            switch self {
//            case .kakaoJwt(let accessToken):
//                let _ = accessToken
//
//                return Data(
//                    """
//                    {
//                        "success" : true,
//                        "response" : {
//                                        "jwt": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJSdW5uaW5nLWhpIiwiaWQiOjEsImV4cCI6MTY3MTc2NjczNH0._B6ObzE6QmhQlHBEwGVmaHQQQyBx_GqgXAsGYkaUreeGZt6OJOgxw4rQkY10zVoa6DqfDU8JSL_A4J6M_aeOzg"
//                                        },
//                        "error": {
//                                    "message": "t",
//                                    "status": 200
//                                }
//                    }
//                    """.utf8)
//            }
//        }
    
}
