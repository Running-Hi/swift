//
//  ServerNetworkServcieProtocol.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/03.
//
import Combine
import Foundation

protocol ServerNetworkServcieProtocol{
    func request(_ accessToken: String) -> AnyPublisher<JwtDataServerDTO, Error>
}
