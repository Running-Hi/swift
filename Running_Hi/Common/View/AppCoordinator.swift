//
//  AppCoordinator.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/19.
//

import UIKit

class AppCoordinator: Coordinator{
    
    override init(identifier: UUID = UUID(), navigationController: UINavigationController) {
        super.init(identifier: identifier, navigationController: navigationController)
    }
    
    func start(){
        let identifier = UUID()
        let viewCoordinator = SignUpNameViewCoordinator(identifier: identifier, navigationController: navigationController)
        self.childCoordinaotors[identifier] = viewCoordinator
        viewCoordinator.start()
        
        
//        let authenticationViewCoordinator = AutheticationViewCoordinator(identifier: identifier, navigationController: navigationController)
//        self.childCoordinaotors[identifier] = authenticationViewCoordinator
//        authenticationViewCoordinator.start()
    }
}
