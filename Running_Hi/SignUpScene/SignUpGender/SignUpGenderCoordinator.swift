//
//  SignUpGenderCoordinator.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/30.
//
import Combine
import Foundation
import UIKit


final class SignUpGenderViewCoordinator: Coordinator{
    private var subscription = Set<AnyCancellable>()
    private var uuidNickname: [UUID: String]
    
    init(uuidNickname: [UUID: String], identifier: UUID, navigationController: UINavigationController) {
        self.uuidNickname = uuidNickname
        super.init(identifier: identifier, navigationController: navigationController)
        
    }
    
    func start(){
        let viewModel = SignUpGenderViewModel()
        
        viewModel.signUpAgePageRequested
            .sink {[weak self] gender in
                guard let uuidNickname = self?.uuidNickname else {return}
                self?.signUpAgePageRequest(uuidNickname, gender)
            }
            .store(in: &subscription)
        
        
        let viewContoller = SignUpGenderViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewContoller, animated: false)
    }
    
    func signUpAgePageRequest(_ uuidNickname: [UUID: String], _ gender: String){
        let identifier = UUID()
        let signUpAgeCoordinator = SignUpAgeViewCoordinator(uuidNickname: uuidNickname, gender: gender, identifier: identifier, navigationController: navigationController)
        self.childCoordinaotors[identifier] = signUpAgeCoordinator
        signUpAgeCoordinator.start()
    }
}
