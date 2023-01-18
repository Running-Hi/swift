//
//  GetJwtUseCaseTest.swift
//  GetJwtUseCaseTest
//
//  Created by 안종표 on 2023/01/09.
//
@testable import Running_Hi
import Combine
import XCTest

final class GetJwtUseCaseTest: XCTestCase {

    private var subscription: Set<AnyCancellable>!
    private var user: User!
    override func setUp() {
        subscription = Set<AnyCancellable>()
        user = User(
            id: "userData: ID",
            gender: "userData: Gender",
            age: 100,
            nickName: "userData: NickName",
            region: "userData: Region",
            accessToken: "userData: AccessToken"
        )
    }
    
    func testGetJwtSuccess(){
        let loginRepository = DummyLoginRepository(isSuccessMode: true)
        let getJwtUseCase = GetJwtUseCase(loginRepository: loginRepository)
        
        getJwtUseCase.gotJwtDataPublisher
            .sink { jwtData in
                guard let jwtData = jwtData else {return}
                
                XCTAssertEqual(jwtData.accessToken, loginRepository.jwtData.accessToken)
                XCTAssertEqual(jwtData.refreshToken, loginRepository.jwtData.refreshToken)
            }
            .store(in: &subscription)
        
        getJwtUseCase.getJwt(for: "무엇이 들어가던 상관없다.")
    }
    func testGetJwtFailure(){
        let loginRepository = DummyLoginRepository(isSuccessMode: false)
        let getJwtUseCase = GetJwtUseCase(loginRepository: loginRepository)
        
        getJwtUseCase.gotJwtDataPublisher
            .sink { jwtData in
                guard let jwtData = jwtData else {return}
                
                XCTAssertEqual(jwtData.accessToken, loginRepository.jwtData.accessToken)
                XCTAssertEqual(jwtData.refreshToken, loginRepository.jwtData.refreshToken)
            }
            .store(in: &subscription)
        
        getJwtUseCase.getJwt(for: "무엇이 들어가던 상관없다.")
    }
    
    func testGetSignUpJwtSuccess(){
        let loginRepository = DummyLoginRepository(isSuccessMode: true)
        let getJwtUseCase = GetJwtUseCase(loginRepository: loginRepository)
        
        getJwtUseCase.gotJwtDataPublisher
            .sink { jwtData in
                guard let jwtData = jwtData else {return}
                
                XCTAssertEqual(jwtData.accessToken, loginRepository.jwtData.accessToken)
                XCTAssertEqual(jwtData.refreshToken, loginRepository.jwtData.refreshToken)
            }
            .store(in: &subscription)
        
        getJwtUseCase.getSignUpJwt(user: user, accessToken: "무엇이 들어가던", jwtAccessToken: "상관없다.")
    }
    func testGetSignUpJwtFailure(){
        let loginRepository = DummyLoginRepository(isSuccessMode: false)
        let getJwtUseCase = GetJwtUseCase(loginRepository: loginRepository)
        
        getJwtUseCase.gotJwtDataPublisher
            .sink { jwtData in
                guard let jwtData = jwtData else {return}
                
                XCTAssertEqual(jwtData.accessToken, loginRepository.jwtData.accessToken)
                XCTAssertEqual(jwtData.refreshToken, loginRepository.jwtData.refreshToken)
            }
            .store(in: &subscription)
        
        getJwtUseCase.getSignUpJwt(user: user, accessToken: "무엇이 들어가던", jwtAccessToken: "상관없다.")
    }
    
    
    
    override func tearDown() {
        subscription = nil
    }

}
