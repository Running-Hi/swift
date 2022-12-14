//
//  KakaoNetworkService.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/17.
//

import Combine

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

enum KakaoAPI{
    case requestLogin

    var url: URL{
        switch self{
        case .requestLogin:
            return URL(string: "https://kauth.kakao.com/oauth/authorize?client_id=b7ceeeeb7b5ea751e2c636bfa9a2d037&redirect_uri=http://localhost:8080/oauth_kakao&response_type=code")!
        }
    }
}


class KakaoNetworkService: KakaoNetworkServiceProtocol{
    static let shared = KakaoNetworkService()

    private init(){}
    
    func requestKakaoLogin() -> AnyPublisher<String, Error>{
        return Future<String, Error> { promise in
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        guard let oauthToken = oauthToken else {return}
                        return promise(.success(oauthToken.accessToken))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
