//
//  KakaoRepositoryProtocol.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/04.
//
import Combine
import Foundation

protocol KakaoRepositoryProtocol{
    func fetchAccessToken() -> AnyPublisher<String, Error>
}
