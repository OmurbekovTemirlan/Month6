//
//  SmsView.swift
//  myCofeHomeApp
//
//  Created by Apple on 6.5.2024.
//

import UIKit

protocol SmsViewDelegate: AnyObject {
    func verifyCode(with code: String)
    func againSand(with code: String)
}

class MessageView: BaseView {
    
    private let titleRestourantLabel: UILabel = {
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
    
    var discriptionLabel: UILabel = {
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
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Подвердить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "ColorGeeks")
        return button
    }()
    
    private let againSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить еще раз", for: .normal)
        button.setTitleColor(.systemGray2, for: .normal)
        return button
    }()
    
    weak var delegate: SmsViewDelegate?
    
    weak var authDelegate: AuthoViewDelegate?
    
    override func setup() {
        super.setup()
        backgroundColor = .systemBackground
        setupAdd()
        setupLayouts()
        
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        againSetButton.addTarget(self, action: #selector(againSetButtonTapped), for: .touchUpInside)
    }
    
    override func setupAdd() {
        super.setupAdd()
        addSubview(titleRestourantLabel)
        addSubview(titleLabel)
        addSubview(discriptionLabel)
        addSubview(smsCodeTF)
        addSubview(signInButton)
        addSubview(againSetButton)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        titleRestourantLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleRestourantLabel.snp.bottom).offset(10)
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
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(smsCodeTF.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        againSetButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc
    private func signInTapped() {
        delegate?.verifyCode(with: smsCodeTF.text ?? "")
       
        }
    @objc
    private func againSetButtonTapped() {

    }
    
}
