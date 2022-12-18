//
//  SignUpViewController.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/18.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "이름을 알려주세요 :)"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var textField: UITextField = {
        var textField = UITextField()
        textField.borderStyle = .none
        textField.textContentType = .name
        return textField
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        
    }
    
    func configureUI(){
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-70)
        }
        
        self.view.addSubview(textField)
        self.textField.snp.makeConstraints{
            $0.top.equalTo(titleLabel).offset(100)
            $0.leading.equalToSuperview().offset(60)
            $0.trailing.equalToSuperview().offset(60)
            
        }
        
        
    }


}

