//
//  SignUpNameViewModel.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/19.
//

import Combine

protocol SignUpNameViewModelInput{
    func continueButtonDidTap()
}
protocol SignUpNameViewModelOutput{
    
}

typealias SignUpNameViewModelProtocol = SignUpNameViewModelInput & SignUpNameViewModelOutput

class SignUpNameViewModel: SignUpNameViewModelProtocol{
    private var subScription = Set<AnyCancellable>()
    
    private var signUpGenderPageRequested = PassthroughSubject<Void, Never>()
    
    func continueButtonDidTap() {
        self.signUpGenderPageRequested.send()
    }
    
    
//    private func
    
    
    
}
