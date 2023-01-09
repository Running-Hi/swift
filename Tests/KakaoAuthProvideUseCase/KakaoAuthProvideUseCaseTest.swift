//
//  KakaoAuthProvideUseCase.swift
//  KakaoAuthProvideUseCase
//
//  Created by 안종표 on 2023/01/06.
//
@testable import Running_Hi

import Combine
import XCTest

final class KakaoAuthProvideUseCaseTest: XCTestCase {

    private var subscription: Set<AnyCancellable>!
    
    override func setUp(){
        subscription = Set<AnyCancellable>()
    }
    
    func testKakaoAuthProvideSuccess(){
        let kakaoRepository = DummyKakaoRepository(isSuccessMode: true)
        let kakaoAuthProvideUseCase = KakaoAuthProvideUseCase(kakaoRepository: kakaoRepository)
    
        kakaoAuthProvideUseCase.gotKakaoAccessTokenPublisher
            .sink { accessToken in
                guard let accessToken = accessToken else {return}
                XCTAssertEqual(accessToken, DummyToken.kakaoAccessToken.tokenValue)
            }
            .store(in: &subscription)
        kakaoAuthProvideUseCase.getKakaoAccessToken()
    }
    
    func testKakaoAuthProvideFailure(){
        let kakaoRepository = DummyKakaoRepository(isSuccessMode: false)
        let kakaoAuthProvideUseCase = KakaoAuthProvideUseCase(kakaoRepository: kakaoRepository)
        
       
        kakaoAuthProvideUseCase.gotKakaoAccessTokenPublisher
            .sink { accessToken in
                guard let accessToken = accessToken else {return}
                XCTAssertEqual(accessToken, DummyToken.kakaoAccessToken.tokenValue)
            }
            .store(in: &subscription)
        kakaoAuthProvideUseCase.getKakaoAccessToken()
    }
    
    override func tearDown() {
        self.subscription = nil
    }

}
