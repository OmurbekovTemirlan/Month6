//
//  StartView.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//

import UIKit

protocol StartViewDelegate: AnyObject {
    func toComeIn()
}

class StartView: BaseView {
    
    weak var delegate: StartViewDelegate?
    
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
    
    private let toComeInBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "ColorGeeks")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signInBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor.systemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setup(){
        super.setup()
        setupAdd()
        setupLayouts()
        
        toComeInBtn.addTarget(self, action: #selector(toComeInTap), for: .touchUpInside)
        
    }
    
    override func setupAdd(){
        super.setupAdd()
        addSubview(titleRestourant)
        addSubview(titleLabel)
        addSubview(toComeInBtn)
        addSubview(signInBtn)
    }
    
    override func setupLayouts(){
        super.setupLayouts()
        
        NSLayoutConstraint.activate([
            
            titleRestourant.topAnchor.constraint(equalTo: topAnchor),
            titleRestourant.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleRestourant.bottomAnchor, constant: 3),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            toComeInBtn.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            toComeInBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            toComeInBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            toComeInBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            toComeInBtn.heightAnchor.constraint(equalToConstant: 40),
            
            
            signInBtn.topAnchor.constraint(equalTo: toComeInBtn.bottomAnchor, constant: 20),
            signInBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            signInBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            signInBtn.heightAnchor.constraint(equalToConstant: 40),
            
        ])
        
    }
    
    @objc
    private func toComeInTap(){
        
        delegate?.toComeIn()
        
    }
    
}
