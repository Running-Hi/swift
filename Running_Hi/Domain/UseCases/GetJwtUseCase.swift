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
    var gotAccessTokenPublisher: AnyPublisher<JWT?, Never>{
        self.$gotAccessToken.eraseToAnyPublisher()
    }
    var gotRefreshTokenPublisher: AnyPublisher<JWT?, Never>{
        self.$gotRefreshToken.eraseToAnyPublisher()
    }
    
    private let loginRepository: LoginRepositoryProtocol
    
    private var subscription = Set<AnyCancellable>()
    @Published private var gotAccessToken: JWT?
    @Published private var gotRefreshToken: JWT?
    
    init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    /* Repository로부터 JwtData를 수신하고 여기서 accessToken과 refreshToken을 jwtdecode해주고 @Published로 받아지면 jwt값을 userDefaults에 저장해줘야됨.
     Repository에서 UserDefaults관련된것도 구현해야한다!
     사실상 뷰로 전달해야하는 데이터는 없기때문에 굳이 리턴값은 없어도 된다.!
     둘다의 페어링 뷰모델보면 pairButtonDidTap()에 pair함수가 리턴값이 없음
     */
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
                let accessToken = try? decode(jwt: jwtData.accessToken)
                let refreshToken = try? decode(jwt: jwtData.refreshToken)
                self?.gotAccessToken = accessToken
                self?.gotRefreshToken = refreshToken
            }
            .store(in: &subscription)
    }
    
    
}
