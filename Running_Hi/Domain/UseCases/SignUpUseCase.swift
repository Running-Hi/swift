//
//  SingUpUseCase.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/17.
//
import Combine
import Foundation
final class SignUpUseCase{
    
    private var subscription = Set<AnyCancellable>()
    
    private let loginRepository: LoginRepositoryProtocol
    init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }
    
    //마지막 regionViewModel에서 Coordinator로 Tabbar로 보내줘야함.
    func signUp(_ user: User, _ accessToken: String, _ refreshToken: String) -> AnyPublisher<User, Error>{
        return self.loginRepository.fetchUser(user, accessToken, refreshToken)
    }
}

