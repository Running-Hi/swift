//
//  JwtDataDTO.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/01.
//

import Foundation
struct JwtDataServerDTO: Codable{
    private let success: Bool
    private var response: ResponseToken
    private var error: ResponseError
    
    private enum codingKeys: String, CodingKey{
        case success, response, error
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        self.success = try container.decode(Bool.self, forKey: .success)
        self.response = (try? container.decode(ResponseToken.self, forKey: .response)) ?? ResponseToken(accessToken: "", refreshToken: "")
        self.error = (try? container.decode(ResponseError.self, forKey: .error)) ?? ResponseError(message: "", status: 200)
    }
    
    func toDomain() -> JwtData{
        return JwtData(
            accessToken: self.response.accessToken,
            refreshToken: self.response.refreshToken
        )
    }
    
}

struct ResponseToken: Codable{
    var accessToken: String
    var refreshToken: String

    init(
        accessToken: String,
        refreshToken: String
    ) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    private enum codingKeys: String, CodingKey{
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
    }
    
}

struct ResponseError: Codable{
    var message: String
    var status: Int
    init(message: String, status: Int) {
        self.message = message
        self.status = status
    }
    
    
    private enum codingKeys: String, CodingKey{
        case message, status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.status = try container.decode(Int.self, forKey: .status)
    }
}
