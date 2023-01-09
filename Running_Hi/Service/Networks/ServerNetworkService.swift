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

final class ServerNetworkService: ServerNetworkServcieProtocol{
    
    static let shared = ServerNetworkService()
    private init() {}
    private var subScription = Set<AnyCancellable>()
    private var provider: MoyaProvider<ServerServiceAPI>!
    private let serverEndPointClosure = {(target: ServerServiceAPI) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            return defaultEndpoint
        }
    }
    
    func request(_ accessToken: String) -> AnyPublisher<JwtDataServerDTO, Error> {
        //나는 여기서 Moya에서 request body보내는 것만 구현하면 된다.
        provider = MoyaProvider<ServerServiceAPI>(endpointClosure: serverEndPointClosure)
        return provider.requestPublisher(.kakaoJwt(accessToken))
            .map(JwtDataServerDTO.self)
            .mapError({ moyaError in
                moyaError as Error
            })
            .eraseToAnyPublisher()
    }
    
}
