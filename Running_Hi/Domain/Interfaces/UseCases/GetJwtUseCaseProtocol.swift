//
//  GetJwtUseCaseProtocol.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/03.
//
import Combine
import Foundation
protocol GetJwtUseCaseProtocol{
    var gotJwtAccessTokenPublisher: AnyPublisher<String?, Never> {get}
    var gotJwtRefreshTokenPublisher: AnyPublisher<String?, Never> {get}
    var errorPublisher: AnyPublisher<Error?, Never> {get}
    func getJwt(for accessToken: String)
    func decodeJwtAccessToken(_ jwtAccessToken: String) -> AnyPublisher<Bool, Never>
}
