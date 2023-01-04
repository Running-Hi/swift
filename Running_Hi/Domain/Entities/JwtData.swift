//
//  Communication.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/24.
//
import Foundation
struct JwtData{
    let accessToken: String
    let refreshToken: String
    
    init(
        accessToken: String,
        refreshToken: String
    ) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
