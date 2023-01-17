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
        let publisher: AnyPublisher<ServerResonseDTO<ResponseToken>, Error> = serverNetworkService.request(accessToken)
        return publisher
            .tryMap{$0.toJwtDataDomain()}
            .eraseToAnyPublisher()
    }
    
    func fetchUser(_ user: User, _ accessToken: String, _ refreshToken: String) -> AnyPublisher<User, Error>{
        let publisher: AnyPublisher<ServerResonseDTO<ResponseSignUpUser>, Error> = serverNetworkService.request(user, accessToken, refreshToken)
        
        return publisher
            .tryMap{$0.toSingUpUserDomain()}
            .eraseToAnyPublisher()
    }

}
