//
//  SignUpGenderViewModel.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/30.
//
import Combine
import Foundation

protocol SignUpGenderViewModelInput{
    func continueButtonDidTapped(_ gender: String)
    func checkGender(_ gender: String)
}
protocol SignUpGenderViewModelOutput{
    var isGenderCheckValidPublisher: AnyPublisher<Bool, Never> { get }
}

typealias SignUpGenderViewModelProtocol = SignUpGenderViewModelInput & SignUpGenderViewModelOutput

final class SignUpGenderViewModel: SignUpGenderViewModelProtocol{
    var isGenderCheckValidPublisher: AnyPublisher<Bool, Never>{ self.$genderCheckValidPublisher.eraseToAnyPublisher() }
    var signUpAgePageRequested = PassthroughSubject<String, Never>()
    
    private var subscription = Set<AnyCancellable>()


    @Published var genderCheckValidPublisher: Bool = false
    
    func continueButtonDidTapped(_ gender: String) {
        self.signUpAgePageRequested.send(gender)
    }

    func checkGender(_ gender: String){
        if gender == "남" || gender == "여" || gender == "성별없음"{
            self.genderCheckValidPublisher = true
        }else{
            self.genderCheckValidPublisher = false
        }
    }
    
    
}
