//
//  KakaoAuthProvideUseCaseProtocol.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/04.
//
import Combine
import Foundation

protocol KakaoAuthProvideUseCaseProtocol{
    var gotKakaoAccessTokenPublisher: AnyPublisher<String?, Never> { get } 
    func getKakaoAccessToken()
}
