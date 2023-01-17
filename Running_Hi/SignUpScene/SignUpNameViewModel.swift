//
//  SignUpNameViewModel.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/19.
//

import Combine
import Foundation

protocol SignUpNameViewModelInput{
    func continueButtonDidTap(_ nickName: [UUID: String])
}
protocol SignUpNameViewModelOutput{
    
}

typealias SignUpNameViewModelProtocol = SignUpNameViewModelInput & SignUpNameViewModelOutput

class SignUpNameViewModel: SignUpNameViewModelProtocol{
    private var subScription = Set<AnyCancellable>()
    
    private var feedPageReqeusted = PassthroughSubject<[UUID: String], Never>()
    
    func continueButtonDidTap(_ nickName: [UUID: String]) {
        self.feedPageReqeusted.send(nickName)
    }
    
    
//    private func
    
    
    
}
