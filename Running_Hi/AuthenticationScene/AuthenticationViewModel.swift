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
    func kakaoLoginButtonDidTap()
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
    
    func kakaoLoginButtonDidTap(){
        self.kakaoLogin()
    }
    
    
    private func kakaoLogin(){
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    guard let oauthToken = oauthToken else {return}
                    self.requestFetchUser(oauthToken.accessToken)
                }
            }
        }
    }
}
//MARK: -- API Communication
extension AuthenticationViewModel{
    func requestFetchUser(_ accessToken: String){
        ServerService.fetchJwt(accessToken)
//            .sink { completion in
//                switch completion{
//                case .finished:
//                    print("requestFetchUser - finished")
//                case .failure(let err):
//                    print("requestFetchUser - \(err)")
//                }
//            } receiveValue: {[weak self] response in
//                guard let self = self else{return}
//
//            }
//            .store(in: &subScription)
    }
}
