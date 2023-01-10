//
//  DummyToken.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/06.
//

import Foundation
enum DummyToken{
    case kakaoAccessToken
    
    var tokenValue: String {
        switch self{
        case .kakaoAccessToken:
            return "It's KakaoAccessToken"
            
        }
    }
}
