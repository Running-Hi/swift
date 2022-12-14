//
//  LoginRepositoryProtocol.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/03.
//
import Combine
import Foundation

protocol LoginRepositoryProtocol{
    func fetchJwt(for accessToken: String) -> AnyPublisher<JwtData, Error>
}
