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

typealias AuthenticationViewModelProtocol = AuthenticationViewModelInput & AuthenticationViewModelOutput

final class AuthenticationViewModel: AuthenticationViewModelProtocol{
    
    var signUpNamePageRequested = PassthroughSubject<Void, Never>()
    var feedPageRequested = PassthroughSubject<Void, Never>()
    
    private let getJwtUseCase: GetJwtUseCaseProtocol
    private let kakaoAuthProvideUsecase: KakaoAuthProvideUseCaseProtocol
    
    init(getJwtUseCase: GetJwtUseCaseProtocol, kakaoAuthProvideUsecase: KakaoAuthProvideUseCaseProtocol) {
        self.getJwtUseCase = getJwtUseCase
        self.kakaoAuthProvideUsecase = kakaoAuthProvideUsecase
    }
    
    private var subscription = Set<AnyCancellable>()
    
    private func bind(){
        self.kakaoAuthProvideUsecase.gotKakaoAccessTokenPublisher
            .sink {[weak self] completion in
                switch completion{
                case .finished:
                    print("AuthenticationViewModel - kakaoLoginButtonDidTap : Success")
                case .failure(let err):
                    print("AuthenticationViewModel - kakaoLoginButtonDidTap : \(err)")
                }
            } receiveValue: {[weak self] accessToken in
                self?.passToken(accessToken)
            }
            .store(in: &subscription)
        //jwt토큰 받은것 처리(UserDefaults에저장)
        self.getJwtUseCase
            .gotJwtDataPublisher
            .sink {[weak self] jwtData in
                guard let jwtData = jwtData else {return}
                let jwtAccessToken = jwtData.accessToken
                self?.getJwtUseCase.decodeJwtAccessToken(jwtAccessToken)
                    .sink {[weak self] isUser in
                        guard let self = self else{return}
                        if isUser{
                            self.feedPageRequested.send()
                        }else{
                            self.signUpNamePageRequested.send()
                        }
                    }.store(in: &self!.subscription)
            }
            .store(in: &subscription)
    }
    
    func kakaoLoginButtonDidTap(){
        self.kakaoAuthProvideUsecase.getKakaoAccessToken()
    }
    func passToken(_ accessToken: String?){
        guard let accessToken = accessToken else {return}
        self.getJwtUseCase.getJwt(for: accessToken)
    }
    
}
//MARK: -- API Communication
extension AuthenticationViewModel{

}
