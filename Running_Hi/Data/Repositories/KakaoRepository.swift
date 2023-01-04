//
//  KakaoRepository.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/04.
//
import Combine
import Foundation

final class KakaoRepository: KakaoRepositoryProtocol{
    
    
    private let kakaoNetworkService: KakaoNetworkServiceProtocol
    
    init(kakaoNetworkService: KakaoNetworkServiceProtocol) {
        self.kakaoNetworkService = kakaoNetworkService
    }
    
    func fetchAccessToken() -> AnyPublisher<String, Error> {
        let publisher: AnyPublisher<String ,Error> = kakaoNetworkService.requestKakaoLogin()
        return publisher
            .eraseToAnyPublisher()
    }
}
