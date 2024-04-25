//
//  AuthoView.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//  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

import UIKit

protocol AuthoViewDelegate: AnyObject {
    func toComeIn(with model: AuthoModel)
}

class AuthoView: BaseView {
    
    weak var delegate: AuthoViewDelegate?

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
    
    private let toComeLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "ColorGeeks 2")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneNumber: UITextField = {
        let tf = UITextField()
        tf.placeholder = "500 222 000"
        tf.backgroundColor = .systemGray5
        tf.layer.cornerRadius = 13
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        tf.leftView = leftView
        tf.leftViewMode = .always
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .phonePad
        return tf
    }()
    
    private let toComeInBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "ColorGeeks")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setup(){
        super.setup()
       
        toComeInBtn.addTarget(self, action: #selector(toComeInTap), for: .touchUpInside)
    }
    
    override func setupAdd(){
        super.setupAdd()
        addSubview(titleRestourant)
        addSubview(titleLabel)
        addSubview(toComeLabel)
        addSubview(phoneNumber)
        addSubview(toComeInBtn)
    }
    
    override func setupLayouts(){
        super.setupLayouts()
        
        NSLayoutConstraint.activate([
            
            titleRestourant.topAnchor.constraint(equalTo: topAnchor),
            titleRestourant.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleRestourant.bottomAnchor, constant: 3),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      
            toComeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            toComeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            phoneNumber.topAnchor.constraint(equalTo: toComeLabel.bottomAnchor, constant: 20),
            phoneNumber.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            phoneNumber.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            phoneNumber.heightAnchor.constraint(equalToConstant: 50),
            
            toComeInBtn.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 20),
            toComeInBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            toComeInBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            toComeInBtn.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    @objc
    private func toComeInTap(){
        let model = AuthoModel(phoneNumber: phoneNumber.text ?? "")
        
        delegate?.toComeIn(with: model)
    }
}
