//
//  GetJwtUseCase.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/03.
//

import JWTDecode

import Combine
import Foundation
enum GetJwtUseCaseError: LocalizedError{
    case tokenExpire
    
    
    var errorDescription: String?{
        switch self{
        case .tokenExpire: return "토큰이 만료되었습니다"
        }
    }
}

final class GetJwtUseCase: GetJwtUseCaseProtocol{

    var gotJwtDataPublisher: AnyPublisher<JwtData?, Never>{ self.$gotJwtData.eraseToAnyPublisher() }
    var errorPublisher: AnyPublisher<Error?, Never>{ self.$error.eraseToAnyPublisher() }
    
    
    private let loginRepository: LoginRepositoryProtocol
    
    private var subscription = Set<AnyCancellable>()
    @Published private var gotJwtData: JwtData?
    @Published private var error: Error?
    init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    func getJwt(for accessToken: String){
        self.loginRepository.fetchJwt(for: accessToken)
            .sink { [weak self] completion in
                guard let _ = self else {return}
                guard case .failure(_) = completion else {return}
            } receiveValue: {[weak self] jwtData in
                self?.gotJwtData = jwtData
                //액세스토큰, 리프레쉬토큰 userDefaults에 저장
            }
            .store(in: &subscription)
    }
    
    func getSignUpJwt(user: User, accessToken: String, jwtAccessToken: String){
        self.loginRepository.fetchSignUpJwt(user, accessToken, jwtAccessToken)
            .sink {[weak self] completion in
                guard let _ = self else {return}
                guard case .failure(_) = completion else {return}
            } receiveValue: { [weak self] jwtData in
                self?.gotJwtData = jwtData
            }
            .store(in: &subscription)

    }
    func decodeJwtAccessToken(_ jwtAccessToken: String) -> AnyPublisher<Bool, Never>{
        //viewModel로부터 jwtAccessToken을 받아서 decoding하고 안에있는 role값이 guest이면 비회원 이니까 false리턴, user이면 회원이니까 true리턴
        return Future<Bool, Never>{ promise in
            let decodedJwtAccessToken = try! decode(jwt: jwtAccessToken)
            let body = decodedJwtAccessToken.body
            if body["role"] as! String == "user"{
                promise(.success(true))
            }else{
                promise(.success(false))
            }
        }.eraseToAnyPublisher()
    }
        
    
}
