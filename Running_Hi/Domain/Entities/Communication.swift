//
//  Communication.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/24.
//

//// MARK: - Communication
//struct Communication: Codable {
//    let receiveSuccess: Bool
//    let receiveResponse: ReceiveResponse
//    let error: ReceiveError
//    enum condingKeys: String, CodingKey{
//        case receiveSuccess = "success"
//        case receiveResponse = "response"
//        case error
//    }
//}
//
//// MARK: - Error
//struct ReceiveError: Codable {
//    let message: String
//    let status: Int
//}
//
//// MARK: - Response
//struct ReceiveResponse: Codable {
//    let jwt: String
//}
// MARK: - Communication
struct Communication: Codable {
    let success: Bool
    let response: Response
    let error: Error
}

// MARK: - Error
struct Error: Codable {
    let message: String
    let status: Int
}

// MARK: - Response
struct Response: Codable {
    let jwt: String
}
