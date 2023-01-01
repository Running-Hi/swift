//
//  serverService.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/18.
//
import Foundation
import Combine

import Moya
import KakaoSDKAuth
import JWTDecode

final class ServerServiceAPIManager{
    private var subScription = Set<AnyCancellable>()
    private static var provider: MoyaProvider<ServerServiceAPI>!
    private static let serverEndPointClosure = {(target: ServerServiceAPI) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            return defaultEndpoint
        }
    }
    
    static func fetchJwt(_ accessToken: String, _ authProvider: String) -> AnyPublisher<Communication, Error>{
        provider = MoyaProvider<ServerServiceAPI>(endpointClosure: serverEndPointClosure)
        return provider.requestPublisher(.jwt(accessToken, authProvider))
            .map(Communication.self)
            .mapError { moyaError in
                return moyaError as Error
            }
            .eraseToAnyPublisher()
    }
}
