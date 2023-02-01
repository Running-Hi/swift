//
//  SignUpViewController.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/18.
//

import UIKit

import Combine
import CombineCocoa
import SnapKit

final class SignUpNameViewController: UIViewController {
    private var subScription = Set<AnyCancellable>()
    private var viewModel: SignUpNameViewModelProtocol!
    
    convenience init(viewModel: SignUpNameViewModelProtocol){
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "이름을 알려주세요 :)"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.textContentType = .name
        textField.borderStyle = .roundedRect
        textField.placeholder = "이름 또는 닉네임을 입력해주세요."
        
        return textField
    }()
    
    private lazy var explainLabel: UILabel = {
        var label = UILabel()
        label.text = "Running-Hi에서 프로필에 표시되는 이름입니다."
        label.textColor = .opaqueSeparator
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var isValidLabel: UILabel = {
        var label = UILabel()
        label.text = "닉네임 길이는 2~16자, 특수문자는 _ 만 가능합니다."
        label.textColor = .systemRed
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("계속", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        
        button.setBackgroundColor(.lightGray, for: .disabled)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.bindUI()
    }
    
    func configureUI(){
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-70)
        }
        
        self.view.addSubview(nameTextField)
        self.nameTextField.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(-40)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
        }
        
        self.view.addSubview(explainLabel)
        self.explainLabel.snp.makeConstraints{
            $0.top.equalTo(self.nameTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
        }
        
        self.view.addSubview(isValidLabel)
        self.isValidLabel.snp.makeConstraints{
            $0.top.equalTo(self.explainLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
        }
        
        
        self.view.addSubview(continueButton)
        self.continueButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
    }
    
    func bindUI(){
        self.viewModel.isNicknameCheckValidPublisher
            .sink {[weak self] isNickName in
                if isNickName{
                    self?.isValidLabel.text = "유효한 닉네임 입니다."
                    self?.continueButton.isEnabled = true
                }else{
                    self?.isValidLabel.text = "닉네임 길이는 2~16자, 특수문자는 _ 만 가능합니다."
                    self?.continueButton.isEnabled = false
                }
            }
            .store(in: &subScription)
        
        self.nameTextField.textPublisher
            .sink {[weak self] nickname in
                guard let nickname = nickname else {return}
                self?.viewModel.checkNickName(nickname)
            }
            .store(in: &subScription)
        
        self.continueButton.tapPublisher
            .sink {[weak self] _ in
                guard let nameText = self?.nameTextField.text else {return}
                let uuid = UUID()
                self?.viewModel.continueButtonDidTap([uuid: nameText])
                
            }
            .store(in: &subScription)

    }

}

