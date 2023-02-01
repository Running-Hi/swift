//
//  AutheticationViewCoordinator.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/19.
//

import UIKit
import Foundation
import Combine

final class AutheticationViewCoordinator: Coordinator{
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
        
        viewModel.signUpNamePageRequested
            .sink { _ in
                self.SignUpNamepageRequest()
            }
            .store(in: &subScription)
        
        let viewContoller = AuthenticationViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewContoller, animated: false)
    }
    
    private func SignUpNamepageRequest(){
        let identifier = UUID()
        let signUpNameCoordinator = SignUpNameViewCoordinator(identifier: identifier, navigationController: navigationController)
        self.childCoordinaotors[identifier] = signUpNameCoordinator
        signUpNameCoordinator.start()
    }
}
