//
//  LoginViewController.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/15.
//

import UIKit
import AuthenticationServices


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
        [appleLoginButton].map{
            loginStackView.addArrangedSubview($0)
        }
    }

  

}
