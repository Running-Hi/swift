//
//  GetJwtUseCase.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/03.
//

import JWTDecode

import Combine
import Foundation

final class GetJwtUseCase: GetJwtUseCaseProtocol{
    var gotAccessTokenPublisher: AnyPublisher<String?, Never>{
        self.$gotAccessToken.eraseToAnyPublisher()
    }
    var gotRefreshTokenPublisher: AnyPublisher<String?, Never>{
        self.$gotRefreshToken.eraseToAnyPublisher()
    }
    
    private let loginRepository: LoginRepositoryProtocol
    
    private var subscription = Set<AnyCancellable>()
    @Published private var gotAccessToken: String?
    @Published private var gotRefreshToken: String?
    
    init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    func getJwt(for accessToken: String){
        self.loginRepository.fetchJwt(for: accessToken)
            .sink { [weak self] completion in
                switch completion{
                case .finished:
                    print("getJwtUseCase - Success")
                case .failure(let err):
                    print("getJwtUseCase - \(err)")
                }
            } receiveValue: {[weak self] jwtData in
                self?.gotAccessToken = jwtData.accessToken
                self?.gotRefreshToken = jwtData.refreshToken
            }
            .store(in: &subscription)
    }
    
    
}
