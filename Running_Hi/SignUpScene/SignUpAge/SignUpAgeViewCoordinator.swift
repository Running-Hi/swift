//
//  SignUpAgeViewCoordinator.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/02/01.
//
import Combine
import Foundation
import UIKit

final class SignUpAgeViewCoordinator: Coordinator{
    private var subscription = Set<AnyCancellable>()
    private var uuidNickname: [UUID: String]
    private var gender: String
    
    init(uuidNickname: [UUID: String], gender: String, identifier: UUID, navigationController: UINavigationController) {
        self.uuidNickname = uuidNickname
        self.gender = gender
        super.init(identifier: identifier, navigationController: navigationController)
    }
    
    func start(){
        //뷰모델 생성하고
        let viewModel = SignUpAgeViewModel()
        
        //뷰모델에서 다음으로 넘어갈 페이지에 스트림오나 관찰하고
        viewModel.signUpRegionPageRequested
            .sink {[weak self] age in
                guard let uuidNickname = self?.uuidNickname, let gender = self?.gender else {return}
                self?.signUpRegionPageRequest(uuidNickname, gender, age)
            }
            .store(in: &subscription)
        
        //현재 뷰컨트롤러 시작
        let viewController = SignUpAgeViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func signUpRegionPageRequest(_ uuidNickname: [UUID: String], _ gender: String, _ age: Int ){
        let identifier = UUID()
        let signUpRegionCoordinator = SignUpRegionViewCoordinator(uuidNickname: uuidNickname, gender: gender, age: age, identifier: identifier, navigationController: navigationController)
        self.childCoordinaotors[identifier] = signUpRegionCoordinator
        signUpRegionCoordinator.start()
    }
}
