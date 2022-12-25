//
//  ServerServiceAPIManagerTests.swift
//  Running_HiTests
//
//  Created by 안종표 on 2022/12/25.
//

import XCTest
//import Moya
import Combine

final class ServerServiceAPIManagerTests: XCTestCase {
//    private let endPointClosure = { (target: T) -> Endpoint in
//        let sampleResponseClosure: () -> EndpointSampleResponse = {
//            EndpointSampleResponse.networkResponse(sampleStatusCode, target.sampleData)
//        }
//
//        return Endpoint(
//            url: URL(target: target).absoluteString,
//            sampleResponseClosure: sampleResponseClosure,
//            method: target.method,
//            task: target.task,
//            httpHeaderFields: target.headers)
//
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
