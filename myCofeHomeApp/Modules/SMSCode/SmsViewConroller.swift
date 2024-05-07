//
//  SmsViewConroller.swift
//  myCofeHomeApp
//
//  Created by Apple on 6.5.2024.
//

import Foundation
import SnapKit

protocol SmsViewDelegate: AnyObject {
    func verifyCide(with code: String)
}

class SmsViewConroller: BaseViewController {
    
    private let smsView = SmsView()
    
    private let authService = AuthenticationService()
   
    override func setup() {
        super.setup()
        view.backgroundColor = .systemBackground
        setupAdd()
        setupLayouts()
        smsView.delegate = self
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
extension SmsViewConroller: SmsViewDelegate {
    func verifyCide(with code: String) {
        authService.verifyPhone(with: code) { result in
            switch result {
            case .success(let data):
                let vc = TabBarViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                print("Пользователб авторизован \(data)")
            case .failure:
                self.showAlert(title: "Ошибка", massage: "Не верный код!")
            }
        }
    }
}
