//
//  SmsView.swift
//  myCofeHomeApp
//
//  Created by Apple on 6.5.2024.
//

import UIKit
import SnapKit

class SmsView: BaseView {
    
    private let titleRestourant: UILabel = {
        let label = UILabel()
        label.text = "Cofee House"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Geeks"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = UIColor(named: "ColorGeeks 1")
        return label
    }()
    
    private let discriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите 6-и значный код, отправленный номер 0502030422"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let smsCodeTF: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.placeholder = "Введите код"
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.backgroundColor = .clear
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1.0
        tf.layer.cornerRadius = 8.0
        return tf
    }()
    
    private let signInBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "ColorGeeks")
        return button
    }()
    
    private let againSetBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить еще раз", for: .normal)
        button.setTitleColor(.systemGray2, for: .normal)
        return button
    }()
    
    weak var delegate: SmsViewDelegate?
    
    override func setup() {
        super.setup()
        backgroundColor = .systemBackground
        setupAdd()
        setupLayouts()
        smsCodeTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        signInBtn.addTarget(self, action: #selector(signIntap), for: .touchUpInside)
    }
    override func setupAdd() {
        super.setupAdd()
        addSubview(titleRestourant)
        addSubview(titleLabel)
        addSubview(discriptionLabel)
        addSubview(smsCodeTF)
        addSubview(signInBtn)
        addSubview(againSetBtn)
    }
    override func setupLayouts() {
        super.setupLayouts()
        
        titleRestourant.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleRestourant.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        discriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(90)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        smsCodeTF.snp.makeConstraints { make in
            make.top.equalTo(discriptionLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        signInBtn.snp.makeConstraints { make in
            make.top.equalTo(smsCodeTF.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        againSetBtn.snp.makeConstraints { make in
            make.top.equalTo(signInBtn.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        delegate?.textFieldDidChange(textField)
        }
    
    @objc
    private func signIntap() {
        delegate?.signInBtn()
        }
    
}
