//
//  KakaoAuthProvideUseCase.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/04.
//

import Foundation
import Combine

import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

final class KakaoAuthProvideUseCase: KakaoAuthProvideUseCaseProtocol{
    var gotKakaoAccessTokenPublisher: AnyPublisher<String?, Never>{
        self.$gotKakaoAccessToken.eraseToAnyPublisher()
    }
    
    private var subscription = Set<AnyCancellable>()
    @Published private var gotKakaoAccessToken: String?
    
    private let kakaoRepository: KakaoRepositoryProtocol
    
    init(kakaoRepository: KakaoRepositoryProtocol) {
        self.kakaoRepository = kakaoRepository
    }
    
    
    func getKakaoAccessToken(){
        self.kakaoRepository.fetchAccessToken()
            .sink {[weak self] completion in
                switch completion{
                case .finished:
                    print("KakaoAuthProvideUseCase-getKakaoAccessToken : Success")
                case .failure(let err):
                    print("KakaoAuthProvideUseCase-getKakaoAccessToken : \(err)")
                }
            } receiveValue: {[weak self] kakaoAccessToken in
                self?.gotKakaoAccessToken = kakaoAccessToken
            }
            .store(in: &subscription)
    }
    
    
}
