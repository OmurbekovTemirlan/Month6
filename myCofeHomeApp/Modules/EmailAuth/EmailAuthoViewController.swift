//
//  EmailAuthoViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 9.5.2024.
//

import Foundation

class EmailAuthoViewController: BaseViewController {
    
    private let emailView = EmailView()
    
    private let authenticationService = AuthenticationService()
    
    override func setup() {
        super.setup()
        view.backgroundColor = .systemBackground
        emailView.delegate = self
    }
    override func setupAdd() {
        super.setupAdd()
        view.add {
            emailView
        }
    }
    override func setupLayouts() {
        super.setupLayouts()
        emailView.snp.makeConstraints { make in
            make.top.bottom.directionalHorizontalEdges.equalToSuperview()
        }
    }
}

extension EmailAuthoViewController: EmailViewDelegate {
    func signInButton(with email: String, password: String) {
        authenticationService.signIn(with: email, password: password) { result in
            switch result {
            case .success:
                let vc = TabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.present(vc, animated: false)
            case .failure:
                self.showAlert(title: "Ошибка", massage: "Не нервый Email или пароль!")
            }
        }
    }
}
