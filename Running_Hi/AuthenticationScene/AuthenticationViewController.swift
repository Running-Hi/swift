//
//  LoginViewController.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/15.
//

import UIKit
import AuthenticationServices
import SafariServices


import SnapKit
import Combine
import CombineCocoa

class AuthenticationViewController: UIViewController {
    let safariViewControllerNotification = Notification.Name(rawValue: "safariViewControllerNotification")
    
    private var subScription = Set<AnyCancellable>()
    private var viewModel: AuthenticationViewModel!
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "러닝-하이"
        label.font = UIFont.systemFont(ofSize: 72)
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()
    
    private lazy var appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        return button
    }()
    
    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "kakao_login_large_wide")
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return button
    }()
    
    private lazy var naverLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("네이버 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .black
        return button
    }()
    
    private lazy var instaLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("인스타 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .black
        return button
    }()
    
    
    
    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //후에 coordinator로 받아야함
        viewModel = AuthenticationViewModel()
        NotificationCenter.default.addObserver(self, selector: #selector(safariLogin(notification:)), name: safariViewControllerNotification, object: nil)
        self.configureUI()
        self.bindUI()
    }
    
    private func configureUI(){
        self.view.backgroundColor = .white
        
        self.view.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(self.view.frame.height * 0.20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        self.view.addSubview(self.loginStackView)
        self.loginStackView.snp.makeConstraints{
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(200)
            $0.leading.equalToSuperview().offset(60)
            $0.trailing.equalToSuperview().offset(-60)
        }
        [appleLoginButton, kakaoLoginButton ,naverLoginButton, instaLoginButton].map{
            loginStackView.addArrangedSubview($0)
        }
   
    }
    
    private func bindUI(){
//        self.appleLoginButton.tapPublisher
//            .sink { _ in
//                //viewModel
//            }
//            .store(in: &subScription)
        self.kakaoLoginButton.tapPublisher
            .sink { _ in
                let url = self.viewModel.kakaoLoginButtonDidTap()
                let safariViewController = SFSafariViewController(url: url)
                safariViewController.delegate = self
                self.present(safariViewController, animated: false)
                
            }
            .store(in: &subScription)
        
        self.naverLoginButton.tapPublisher
            .sink { _ in
                //viewModel
            }
            .store(in: &subScription)
        self.instaLoginButton.tapPublisher
            .sink { _ in
                //viewModel
            }
            .store(in: &subScription)
    }
    


}
extension AuthenticationViewController: SFSafariViewControllerDelegate{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("safariViewControllerNotification"), object: nil)
    }
    @objc func safariLogin(notification: Notification){
        NotificationCenter.default.removeObserver(self, name: Notification.Name("safariViewControllerNotification"), object: nil)
        guard let url = notification.object as? URL else{
            return
        }
        //url parse
        print(url)
        
    }
}
