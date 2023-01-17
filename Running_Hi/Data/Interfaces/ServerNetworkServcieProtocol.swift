//
//  ServerNetworkServcieProtocol.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/03.
//
import Combine
import Foundation

protocol ServerNetworkServcieProtocol{
    func request(_ accessToken: String) -> AnyPublisher<ServerResonseDTO<ResponseToken>, Error>
    func request<T: Decodable>(_ user: User, _ accessToken: String, _ jwtAccessToken: String) -> AnyPublisher<T, Error> 
}
