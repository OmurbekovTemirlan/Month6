//
//  AuthoView.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//  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

import UIKit

class AuthoView: BaseView {
    
    private let titleRestourant: UILabel = {
        let label = UILabel()
        label.text = "Cofee House"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Geeks"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = UIColor(named: "ColorGeeks 1")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let singInLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "ColorGeeks 2")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneNumberTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "+996 500 222 000"
        tf.backgroundColor = .systemGray5
        tf.layer.cornerRadius = 13
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        tf.leftView = leftView
        tf.leftViewMode = .always
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .phonePad
        return tf
    }()
    
    private let signInBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "ColorGeeks")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: AuthoViewDelegate?
    
    override func setup(){
        super.setup()
       
        signInBtn.addTarget(self, action: #selector(signInTap), for: .touchUpInside)
        phoneNumberTextField.addTarget(self, action: #selector(phoneNumberEdits), for: .editingChanged)
        
    }
    
    override func setupAdd(){
        super.setupAdd()
        addSubview(titleRestourant)
        addSubview(titleLabel)
        addSubview(singInLabel)
        addSubview(phoneNumberTextField)
        addSubview(signInBtn)
    }
    
    override func setupLayouts(){
        super.setupLayouts()
        
        NSLayoutConstraint.activate([
            
            titleRestourant.topAnchor.constraint(equalTo: topAnchor),
            titleRestourant.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleRestourant.bottomAnchor, constant: 3),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      
            singInLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            singInLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: singInLabel.bottomAnchor, constant: 20),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            
            signInBtn.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            signInBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            signInBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            signInBtn.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    
    @objc
    private func phoneNumberEdits(_ textField: UITextField) {
        delegate?.phoneNumberTfEdits()
    }
    
    @objc
    private func signInTap() {
        let model = AuthModel(phoneNumber: phoneNumberTextField.text ?? "")
        delegate?.signIn(with: model )
    }
}
