//
//  SignUpRegionViewController.swift
//  Running_Hi
//
//  Created by 안종표 on 2023/02/09.
//
import Combine
import Foundation
import UIKit

import CombineCocoa
import SnapKit

final class SignUpRegionViewController: UIViewController {
    private var subscription = Set<AnyCancellable>()
    private var viewModel: SignUpRegionViewModelProtocol!
    var arr: [String] = ["강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구"]
    convenience init(viewModel: SignUpRegionViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "거주지역구를 알려주세요 :)"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var explainLabel: UILabel = {
        var label = UILabel()
        label.text = "Running-Hi에서 프로필에 표시되는 지역입니다."
        label.textColor = .opaqueSeparator
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var regionPickerView: UIPickerView = {
        var pickerview = UIPickerView()
        return pickerview
    }()
    
    private lazy var finishButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("회원가입 완료", for: .normal)
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
    
    override func viewWillLayoutSubviews() {
        self.selectedPickerViewUICustom()
    }
    
    func configureUI(){
        regionPickerView.delegate = self
        
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-50)
        }
        
        self.view.addSubview(regionPickerView)
        self.regionPickerView.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(-40)
            $0.leading.equalToSuperview().offset(150)
            $0.trailing.equalToSuperview().offset(-50)
        }
        
        self.view.addSubview(explainLabel)
        self.explainLabel.snp.makeConstraints{
            $0.top.equalTo(self.regionPickerView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
        }
        
        self.view.addSubview(finishButton)
        self.finishButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
    }
    
    func bindUI(){
       
    }
    
    func selectedPickerViewUICustom(){
        regionPickerView.subviews[1].backgroundColor = .clear
        let topLine = UIView(frame: CGRect(x: 13, y: 0, width: 150, height: 0.8))
        let underLine = UIView(frame: CGRect(x: 13, y: 60, width: 150, height: 0.8))
        
        topLine.backgroundColor = UIColor(rgb: 0x0061B4)
        underLine.backgroundColor = UIColor(rgb: 0x0061B4)
        
        
        regionPickerView.subviews[1].addSubview(topLine)
        regionPickerView.subviews[1].addSubview(underLine)
    }
}


extension SignUpRegionViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        
        let regionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        regionLabel.text = arr[row]
        regionLabel.textAlignment = .center
        regionLabel.font = UIFont.systemFont(ofSize: 28, weight: .light)
        
        view.addSubview(regionLabel)
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arr.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selected=\(row)")
    }
    
}
