//
//  DummyKakaoRepository.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/06.
//
import Combine
import Foundation

class DummyKakaoRepository: KakaoRepositoryProtocol{
    var isSuccessMode: Bool = true
    
    private let accessToken = "It's KakaoAccessToken"
    
    init(isSuccessMode: Bool) {
        self.isSuccessMode = isSuccessMode
    }
    
    
    func fetchAccessToken() -> AnyPublisher<String, Error> {
        if self.isSuccessMode{
            return Just(self.accessToken).setFailureType(to: Error.self).eraseToAnyPublisher()
        }else{
            return Fail(error: DummyError.failed).eraseToAnyPublisher()
        }
    }
    
    
}


