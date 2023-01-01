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

import Moya
import JWTDecode

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
                    self.requestFetchJwt(oauthToken.accessToken, "kakao")
                }
            }
        }
    }
}
//MARK: -- API Communication
extension AuthenticationViewModel{
    func requestFetchJwt(_ accessToken: String, _ authProvider: String){
        ServerServiceAPIManager.fetchJwt(accessToken, authProvider)
            .sink { completion in
                switch completion{
                case .finished:
                    print("AuthenticationViewModel-requestFetchJwt : Finished")
                case .failure(let err):
                    print("AuthenticationViewModel-requestFetchJwt : \(err)")
                }
            } receiveValue: { communication in
                if communication.receiveSuccess{
                    //jwt토큰 받는것 성공
                    do{
//                        let jwt = try decode(jwt: communication.receiveResponse.jwt)
//                        print(jwt)
                        
                    }catch(let err){
                        print("AuthenticationViewModel - decodingError \(err)")
                    }
                }else{
                    //jwt토큰 받는것 실패
                    //message와 status코드 확인
                    //토큰 만료시 재요청
                    
                }
                
            }
            .store(in: &subScription)
    }
}
