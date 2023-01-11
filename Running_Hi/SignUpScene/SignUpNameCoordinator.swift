//
//  SingUpNameCoordinator.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/11.
//
import UIKit
import Foundation
import Combine

class SignUpNameCoordinator: Coordinator{
    private var subScription = Set<AnyCancellable>()
    
    override init(identifier: UUID, navigationController: UINavigationController) {
        super.init(identifier: identifier, navigationController: navigationController)
    }
    func start(){
        let viewModel = SignUpNameViewModel()
        
        let viewContoller = SignUpNameViewController()
        self.navigationController.pushViewController(viewContoller, animated: false)
    }
}
