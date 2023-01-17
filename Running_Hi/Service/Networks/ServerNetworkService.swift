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
enum ServerNetworkServiceError: Int, LocalizedError{
    case tokenExpired = 401
    var errorDescription: String?{
        switch self{
        case .tokenExpired: return "401: tokenExpired"
        }
    }
}

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
    
    func request<T: Decodable>(_ accessToken: String) -> AnyPublisher<T, Error> {
        provider = MoyaProvider<ServerServiceAPI>(endpointClosure: serverEndPointClosure)
        return provider.requestPublisher(.kakaoJwt(accessToken))
            .map{$0.data}
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ moyaError in
                moyaError as Error
            })
            .eraseToAnyPublisher()
    }
    
    func request<T: Decodable>(_ user: User, _ accessToken: String, _ jwtAccessToken: String) -> AnyPublisher<T, Error> {
        provider = MoyaProvider<ServerServiceAPI>(endpointClosure: serverEndPointClosure)
        return provider.requestPublisher(.signUp(user, accessToken, jwtAccessToken))
            .map{$0.data}
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ moyaError in
                moyaError as Error
            })
            .eraseToAnyPublisher()
    }
}
