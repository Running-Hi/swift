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
    
    override func setUp() {
        subscription = Set<AnyCancellable>()
    }
    
    func testGetJwtSuccess(){
        let loginRepository = DummyLoginRepository(isSuccessMode: true)
        let getJwtUseCase = GetJwtUseCase(loginRepository: loginRepository)
        
        getJwtUseCase.gotAccessTokenPublisher
            .sink { accessToken in
                guard let accessToken = accessToken else {return}
                XCTAssertEqual(accessToken, loginRepository.jwtData.accessToken)
            }
            .store(in: &subscription)
        getJwtUseCase.gotRefreshTokenPublisher
            .sink { refreshToken in
                guard let refreshToken = refreshToken else {return}
                XCTAssertEqual(refreshToken, loginRepository.jwtData.refreshToken)
            }
            .store(in: &subscription)
        getJwtUseCase.getJwt(for: "무엇이 들어가던 상관없다.")
    }
    func testGetJwtFailure(){
        let loginRepository = DummyLoginRepository(isSuccessMode: false)
        let getJwtUseCase = GetJwtUseCase(loginRepository: loginRepository)
        
        getJwtUseCase.gotAccessTokenPublisher
            .sink { accessToken in
                guard let accessToken = accessToken else {return}
                XCTAssertEqual(accessToken, loginRepository.jwtData.accessToken)
            }
            .store(in: &subscription)
        getJwtUseCase.gotRefreshTokenPublisher
            .sink { refreshToken in
                guard let refreshToken = refreshToken else {return}
                XCTAssertEqual(refreshToken, loginRepository.jwtData.refreshToken)
            }
            .store(in: &subscription)
        getJwtUseCase.getJwt(for: "무엇이 들어가던 상관없다.")
    }
    
    override func tearDown() {
        subscription = nil
    }

}
