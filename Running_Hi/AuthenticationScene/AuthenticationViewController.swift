//
//  LoginViewController.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/15.
//

import UIKit
import AuthenticationServices
import SnapKit

class AuthenticationViewController: UIViewController {
        
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
        button.cornerRadius = 22
        return button
    }()
    
    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("카카오 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private lazy var instaLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("인스타 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private lazy var naverLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("네이버 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
       
    }
    
    private func configureUI(){
        self.view.backgroundColor = .cyan
        self.view.addSubview(self.loginStackView)
        
        [appleLoginButton, instaLoginButton, kakaoLoginButton, naverLoginButton].map{
            loginStackView.addArrangedSubview($0)
        }
        
        
    }

  

}
