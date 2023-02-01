//
//  SignUpGenderViewController.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/01/30.
//
import Combine
import UIKit

import CombineCocoa
import SnapKit

final class SignUpGenderViewController: UIViewController {
    private var subscription = Set<AnyCancellable>()
    private var viewModel: SignUpGenderViewModelProtocol!
    
    convenience init(viewModel: SignUpGenderViewModelProtocol){
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "성별을 알려주세요 :)"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var genderTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.textContentType = .name
        textField.borderStyle = .roundedRect
        textField.placeholder = "성별을 입력해주세요."
        
        return textField
    }()
    
    private lazy var explainLabel: UILabel = {
        var label = UILabel()
        label.text = "Running-Hi에서 프로필에 표시되는 성별입니다."
        label.textColor = .opaqueSeparator
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var exampleLabel: UILabel = {
        var label = UILabel()
        label.text = "ex) 남, 여, 성별없음"
        label.textColor = .opaqueSeparator
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
        
        self.view.addSubview(genderTextField)
        self.genderTextField.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(-40)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
        }
        
        self.view.addSubview(explainLabel)
        self.explainLabel.snp.makeConstraints{
            $0.top.equalTo(self.genderTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
        }
        
        self.view.addSubview(exampleLabel)
        self.exampleLabel.snp.makeConstraints{
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
        self.viewModel.isGenderCheckValidPublisher
            .sink {[weak self] check in
                if check{ self?.continueButton.isEnabled = true}
                else {self?.continueButton.isEnabled = false}
            }
            .store(in: &subscription)
        
        self.genderTextField.textPublisher
            .sink {[weak self] genderText in
                guard let gender = genderText else {return}
                self?.viewModel.checkGender(gender)
            }
            .store(in: &subscription)
        
        self.continueButton.tapPublisher
            .sink {[weak self] _ in
                if let gender = self?.genderTextField.text{
                    self?.viewModel.continueButtonDidTapped(gender)
                }
            }
            .store(in: &subscription)
    }
}
