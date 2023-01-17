//
//  DummyLoginRepository.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/09.
//
import Combine
import Foundation

final class DummyLoginRepository: LoginRepositoryProtocol{
    
    
    var isSuccessMode: Bool = true
    
    let jwtData: JwtData = JwtData(
        accessToken: "aaaccceeesssTTToookkkeeennn",
        refreshToken: "rreeffrreesshhTTookkeenn"
    )
    let userData: User = User(
        id: "userData: ID",
        gender: "userData: Gender",
        age: 100,
        nickName: "userData: NickName",
        region: "userData: Region",
        accessToken: "userData: AccessToken",
        refreshToken: "userData: RefreshToken"
    )
    
    init(isSuccessMode: Bool) {
        self.isSuccessMode = isSuccessMode
    }
    
    func fetchJwt(for accessToken: String) -> AnyPublisher<JwtData, Error> {
        if self.isSuccessMode{
            return Just(self.jwtData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }else{
            return Fail(error: DummyError.failed).eraseToAnyPublisher()
        }
    }
    func fetchUser(_ user: User, _ accessToken: String, _ refreshToken: String) -> AnyPublisher<User, Error> {
        if self.isSuccessMode{
            return Just(self.userData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }else{
            return Fail(error: DummyError.failed)
                .eraseToAnyPublisher()
        }
    }
}
