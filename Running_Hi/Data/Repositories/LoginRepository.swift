//
//  LoginRepository.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/03.
//
import Combine
import Foundation

final class LoginRepository: LoginRepositoryProtocol{
    private let serverNetworkService: ServerNetworkServcieProtocol
    
    init(serverNetworkService: ServerNetworkServcieProtocol) {
        self.serverNetworkService = serverNetworkService
    }
    
    func fetchJwt(for accessToken: String) -> AnyPublisher<JwtData, Error> {
        let publisher: AnyPublisher<JwtDataServerDTO, Error> = serverNetworkService.request(accessToken)
        return publisher
            .map{$0.toDomain()}
            .eraseToAnyPublisher()
    }

}
