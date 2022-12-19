//
//  AuthenticationViewModel.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/17.
//

import Foundation
import AuthenticationServices
import Combine

import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

import Alamofire

protocol AuthenticationViewModelInput{
//    func appleLoginButtonDidTap()
    func kakaoLoginButtonDidTap() -> URL
//    func naverLoginButtonDidTap()
//    func instaLoginButtonDidTap()
}
protocol AuthenticationViewModelOutput{
//    var errorPublisher: AnyPublisher<Error?, Never>{get}
    
}

typealias AuthenticationViewModelPrococol = AuthenticationViewModelInput & AuthenticationViewModelOutput

final class AuthenticationViewModel: AuthenticationViewModelPrococol{
    
    var signUpNamePageRequested = PassthroughSubject<Void, Never>()
    
    private var subScription = Set<AnyCancellable>()

    func kakaoLoginButtonDidTap() -> URL{
        return self.getRequestLoginURL()
    }
    
    
    private func getRequestLoginURL() -> URL{
        return KakaoAPI.requestLogin.url
    }
    
    
//    func fetchAuthenticationCode(){
//        KakaoNetworkService.shared.requestLogin()
//            .sink { completion in
//                switch completion{
//                case .failure(let err):
//                    print("AuthenticationViewModel - fetchAuthenticationCode : \(err)")
//                case .finished:
//                    print("AuthenticationViewModel - fetchAuthenticationCode : finished")
//                }
//            } receiveValue: { authentication in
//                print(authentication.code)
//            }
//            .store(in: &subScription)
//    }
    
    
}
