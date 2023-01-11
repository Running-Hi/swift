//
//  GetJwtUseCaseProtocol.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/03.
//
import Combine
import Foundation
protocol GetJwtUseCaseProtocol{
    var gotAccessTokenPublisher: AnyPublisher<String?, Never> {get}
    var gotRefreshTokenPublisher: AnyPublisher<String?, Never> {get}
    var errorPublisher: AnyPublisher<Error?, Never> {get}
    func getJwt(for accessToken: String)
}
