//
//  User.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/21.
//

import Foundation

struct User: Codable{
    var id: String
    var gender: String
    var age: Int
    var nickName: String
    var region: String
    var accessToken: String
}
