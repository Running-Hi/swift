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
    func checkNickName(_ nickName: String)
}
protocol SignUpNameViewModelOutput{
    var isNicknameCheckValidPublisher: AnyPublisher<Bool, Never> {get}
}

typealias SignUpNameViewModelProtocol = SignUpNameViewModelInput & SignUpNameViewModelOutput

final class SignUpNameViewModel: SignUpNameViewModelProtocol{
    var isNicknameCheckValidPublisher: AnyPublisher<Bool, Never> { self.$nicknameCheckValidPublisher.eraseToAnyPublisher() }
    var signUpGenderPageRequested = PassthroughSubject<[UUID: String], Never>()
    
    private var subscription = Set<AnyCancellable>()
    
    @Published var nicknameCheckValidPublisher: Bool = false
    
    func continueButtonDidTap(_ uuidNickName: [UUID: String]) {
        self.signUpGenderPageRequested.send(uuidNickName)
    }
    
    func checkNickName(_ nickName: String){
        if nickName.count >= 2 && nickName.count <= 16{
            for nick in nickName{
                if !nick.isLetter{
                    if nick == "_" {continue}
                    self.nicknameCheckValidPublisher = false
                    return
                }
            }
            self.nicknameCheckValidPublisher = true
        }else{
            self.nicknameCheckValidPublisher = false
        }
    }
}
