//
//  JwtDataDTO.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/01.
//

import Foundation
struct ServerResonseDTO<T: Codable>: Codable{
    private let success: Bool
    private var response: T
    private var error: ResponseError
    
    private enum codingKeys: String, CodingKey{
        case success, response, error
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        self.success = try container.decode(Bool.self, forKey: .success)
        self.response = try container.decode(T.self, forKey: .response)
        self.error = (try? container.decode(ResponseError.self, forKey: .error)) ?? ResponseError(message: "", status: 200)
    }
    
    func toJwtDataDomain() -> JwtData{
        let response = self.response as? ResponseToken
        return JwtData(
            accessToken: response!.accessToken,
            refreshToken: response!.refreshToken
        )
    }
    
    func toSingUpUserDomain() -> User{
        let response = self.response as? ResponseSignUpUser
        return User(
            id: response!.id,
            gender: response!.gender,
            age: response!.age,
            nickName: response!.nickName,
            region: response!.region,
            accessToken: response!.accessToken
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

struct ResponseSignUpUser: Codable{
    var id: String
    var gender: String
    var age: Int
    var nickName: String
    var region: String
    var accessToken: String
    var refreshToken: String
    private enum codingkeys: String, CodingKey{
        case id, gender, age, nickName, region
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
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
