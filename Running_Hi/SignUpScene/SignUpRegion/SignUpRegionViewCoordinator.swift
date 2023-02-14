//
//  SignUpRegionViewCoordinator.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/02/09.
//
import Combine
import Foundation
import UIKit

final class SignUpRegionViewCoordinator: Coordinator{
    private var subscription = Set<AnyCancellable>()
    private var uuidNickname: [UUID: String]
    private var gender: String
    private var age: Int
    init(uuidNickname: [UUID: String], gender: String, age: Int, identifier: UUID, navigationController: UINavigationController) {
        self.uuidNickname = uuidNickname
        self.gender = gender
        self.age = age
        super.init(identifier: identifier, navigationController: navigationController)
    }
    
    func start(){
        //뷰모델 생성하고
        let viewModel = SignUpRegionViewModel()
        
        //뷰모델에서 다음으로 넘어갈 페이지에 스트림오나 관찰하고
        
        //현재 뷰컨트롤러 시작
        let viewController = SignUpRegionViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    
}
