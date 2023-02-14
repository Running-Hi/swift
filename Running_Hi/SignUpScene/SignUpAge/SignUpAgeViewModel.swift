//
//  SignUpAgeViewModel.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/02/01.
//
import Combine
import Foundation

protocol SignUpAgeViewModelInput{
    func continueButtonDidTapped(_ ageStr: String)
    func checkAge(_ ageStr: String)
}
protocol SignUpAgeViewModelOutput{
    var isAgeCheckValidPublisher: AnyPublisher<Bool, Never> { get }
}

typealias SignUpAgeViewModelProtocol = SignUpAgeViewModelInput & SignUpAgeViewModelOutput

final class SignUpAgeViewModel: SignUpAgeViewModelProtocol{
    var isAgeCheckValidPublisher: AnyPublisher<Bool, Never>{ self.$ageCheckValidPublisher.eraseToAnyPublisher() }
    var signUpRegionPageRequested = PassthroughSubject<Int, Never>()
    
    private var subscription = Set<AnyCancellable>()
    
    @Published var ageCheckValidPublisher: Bool = false
    
    func checkAge(_ ageStr: String) {
        if ageStr.count <= 3 && ageStr.count >= 1{
            for a in ageStr{
                if !a.isNumber{
                    self.ageCheckValidPublisher = false
                    return
                }
            }
            self.ageCheckValidPublisher = true
        }else{
            self.ageCheckValidPublisher = false
        }
    }
    
    func continueButtonDidTapped(_ ageStr: String) {
        let age = toInt(ageStr)
        self.signUpRegionPageRequested.send(age)
    }
    
    func toInt(_ ageStr: String) -> Int{
        return Int(ageStr)!
    }
    
}
