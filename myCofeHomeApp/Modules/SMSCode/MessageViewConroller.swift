//
//  SmsViewConroller.swift
//  myCofeHomeApp
//
//  Created by Apple on 6.5.2024.
//

import Foundation
import SnapKit

class MessageViewConroller: BaseViewController {
    
    private let smsView = MessageView()
    
    private let authService = AuthenticationService()
    
     var phoneNumber: String?
   
    override func setup() {
        super.setup()
        view.backgroundColor = .systemBackground
        setupAdd()
        setupLayouts()
        smsView.delegate = self
        
        if let phoneNumber = phoneNumber {
            smsView.discriptionLabel.text = "Введите 6-значный код, отправленный на номер \(phoneNumber)"
        }
    }
    
    override func setupAdd() {
        super.setupAdd()
        view.addSubview(smsView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        smsView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

extension MessageViewConroller: SmsViewDelegate {
    func verifyCode(with code: String) {
        authService.verifyPhone(with: code) { result in
            switch result {
            case .success(let data):
                let vc = TabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.present(vc, animated: true)
                print("Пользователб авторизован \(data)")
            case .failure:
                self.showAlert(title: "Ошибка", massage: "Не верный код!")
            }
        }
    }
    
    func againSand(with code: String) {
        
    }
}
