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
        let serverNetworkService = ServerNetworkService.shared
        let kakaoNetworkService = KakaoNetworkService.shared
        
        
        let loginRepository = LoginRepository(serverNetworkService: serverNetworkService)
        let kakaoRepository = KakaoRepository(kakaoNetworkService: kakaoNetworkService)
        
        let getJwtUseCase = GetJwtUseCase(loginRepository: loginRepository)
        let kakaoAuthProvideUseCase = KakaoAuthProvideUseCase(kakaoRepository: kakaoRepository)
        
        let viewModel = AuthenticationViewModel(getJwtUseCase: getJwtUseCase, kakaoAuthProvideUsecase: kakaoAuthProvideUseCase)
        
        let viewContoller = AuthenticationViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewContoller, animated: false)
    }
}
