//
//  SingUpNameCoordinator.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/11.
//
import UIKit
import Foundation
import Combine

final class SignUpNameViewCoordinator: Coordinator{
    private var subScription = Set<AnyCancellable>()
    
    override init(identifier: UUID, navigationController: UINavigationController) {
        super.init(identifier: identifier, navigationController: navigationController)
    }
    func start(){
        let viewModel = SignUpNameViewModel()
        
        viewModel.signUpGenderPageRequested
            .receive(on: DispatchQueue.main)
            .sink {[weak self] uuidNickname in
                self?.signUpGenderpageRequest(uuidNickname)
            }
            .store(in: &subScription)
        
        let viewContoller = SignUpNameViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewContoller, animated: false)
    }
    
    func signUpGenderpageRequest(_ uuidNickname: [UUID: String]){
        let identifier = UUID()
        let signUpGenderCoordinator = SignUpGenderViewCoordinator(uuidNickname: uuidNickname, identifier: identifier, navigationController: navigationController)
        self.childCoordinaotors[identifier] = signUpGenderCoordinator
        signUpGenderCoordinator.start()
    }
}
