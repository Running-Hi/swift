//
//  SignUpRegionViewModel.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/02/09.
//
import Combine
import Foundation

protocol SignUpRegionViewModelInput{
    func finishButtonDidTapped(_ region: String)
    
}
protocol SignUpRegionViewModelOutput{
    
    
}
typealias SignUpRegionViewModelProtocol = SignUpRegionViewModelInput & SignUpRegionViewModelOutput
final class SignUpRegionViewModel: SignUpRegionViewModelProtocol{
    
    
    private var subscription = Set<AnyCancellable>()
    
    
    func finishButtonDidTapped(_ region: String) {
        var a = 0
    }
    
    
}
