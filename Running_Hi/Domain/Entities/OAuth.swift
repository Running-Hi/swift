//
//  OAuth.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/23.
//


struct OAuth: Codable{
    var accessToken: String
    var provider: String
    enum codingkeys:String, CodingKey{
        case accessToken = "access_token"
        case provider
    }
}


