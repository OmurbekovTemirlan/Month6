//
//  EmailView.swift
//  myCofeHomeApp
//
//  Created by Apple on 10.5.2024.
//

import UIKit
import SnapKit

protocol EmailViewDelegate: AnyObject {
    func signInButton(with email: String, password: String)
}

class EmailView: BaseView {
    
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
    
    private let singInLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "ColorGeeks 2")
        return label
    }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "omurbekov_t@email.com"
        tf.backgroundColor = .systemGray5
        tf.layer.cornerRadius = 13
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        tf.leftView = leftView
        tf.leftViewMode = .always
        tf.keyboardType = .phonePad
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Введите пароль"
        tf.backgroundColor = .systemGray5
        tf.layer.cornerRadius = 13
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        tf.leftView = leftView
        tf.leftViewMode = .always
        tf.keyboardType = .phonePad
        return tf
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "ColorGeeks")
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "ColorGeeks")
        return button
    }()
    
    weak var delegate: EmailViewDelegate?
    
    override func setup() {
        super.setup()
        
        signInButton.addTarget(self, action: #selector(signInButtonTap), for: .touchUpInside)
       
    }
    
    override func setupAdd() {
        super.setupAdd()
        add {
            titleRestourant
            titleLabel
            singInLabel
            emailTextField
            passwordTextField
            signInButton
            registerButton
        }
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        titleRestourant.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(130)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleRestourant.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        singInLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(15)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(singInLabel.snp.bottom).offset(15)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.size.equalTo(45)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.size.equalTo(45)
        }
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalToSuperview().inset(40)
            make.size.equalTo(40)
        }
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalToSuperview().inset(40)
            make.size.equalTo(40)
        }
    }
    
    func clearTextFields() {
            emailTextField.text = ""
            passwordTextField.text = ""
        }
    
    @objc
    private func signInButtonTap() {
        delegate?.signInButton(
            with: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }
}
