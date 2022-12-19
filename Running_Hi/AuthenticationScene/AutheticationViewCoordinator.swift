//
//  AutheticationViewCoordinator.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/19.
//

import UIKit
import Foundation

import Combine

class AutheticationViewCoordinator: Coordinator{
    private var subScription = Set<AnyCancellable>()
    
    override init(identifier: UUID, navigationController: UINavigationController) {
        super.init(identifier: identifier, navigationController: navigationController)
    }
    func start(){
        let viewModel = AuthenticationViewModel()
        let viewContoller = AuthenticationViewController()
        self.navigationController.pushViewController(viewContoller, animated: false)
    }
}
