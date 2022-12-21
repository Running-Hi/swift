//
//  serverService.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/18.
//
import Foundation
import Combine

import Alamofire
import KakaoSDKAuth
import JWTDecode

enum serverAPI{
    case fetchUser(_ accessToken: String)
    
    var url: URL{
        switch self{
        case .fetchUser(let accessToken):
            return URL(string: "https://oauth-test-web.onrender.com/jwt/%7Bjwt/\(accessToken)")!
        }
    }
    
}

final class ServerService{
    private var subScription = Set<AnyCancellable>()
    
    static func fetchJwt(_ accessToken: String){
        AF.request(serverAPI.fetchUser(accessToken).url)
            .validate()
            .response{ response in
                if let jwtAceesToken = response.response?.allHeaderFields["Authorization"] as? String{
                    UserDefaults.standard.set(jwtAceesToken, forKey: jwtAceesToken)
                    let jwt = try decode(jwt: jwtAceesToken)
                    print(jwt)
                }
            }

    }
}
