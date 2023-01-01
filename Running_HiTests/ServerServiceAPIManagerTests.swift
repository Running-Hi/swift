//
//  ServerServiceAPIManagerTests.swift
//  Running_HiTests
//
//  Created by 안종표 on 2022/12/25.
//

import XCTest
import Combine
@testable import Running_Hi

import Moya
import JWTDecode

final class ServerServiceAPIManagerTests: XCTestCase {
    private var subscription: Set<AnyCancellable>!
//    private var sut: ServerServiceAPIManager!
    private var testingProvider: MoyaProvider<ServerServiceAPI>!
    
    private let customEndpointClosure = { (target: TargetType) -> Endpoint in
        let sampleResponseClosure: () -> EndpointSampleResponse = {
            EndpointSampleResponse.networkResponse(200, target.sampleData)
        }
        
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: sampleResponseClosure,
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers)
    }
    
    override func setUpWithError() throws{
        subscription = Set<AnyCancellable>()
        testingProvider = MoyaProvider<ServerServiceAPI>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
    }
    func testFetchJwtSuccess() {
        let expectation = XCTestExpectation()
        let mockObject = ServerServiceAPI
            .jwt("accesstoken이다", "kakao이다")
            .sampleData
    
    }
    
}
