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
        //회원가입으로 가냐, 탭바로 가냐
        //이건 뷰모델에서 서버에서 받은값에 따라 이미 회원이면 탭바로가주고
        //신규회원이면 singUp으로 갈건데, 
        let viewModel = AuthenticationViewModel()
        let viewContoller = AuthenticationViewController()
        self.navigationController.pushViewController(viewContoller, animated: false)
    }
}
