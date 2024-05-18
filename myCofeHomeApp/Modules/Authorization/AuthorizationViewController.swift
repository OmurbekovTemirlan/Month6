//
//  AuthorizationViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//
  
import UIKit

class AuthorizationViewController: BaseViewController {
    
    private let authoView = AuthoView()
    
    private let sessionManager = UserSessionManager.shared
    
    private let authService = AuthenticationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        
        setup()
    }

    override func setup(){
        super.setup()
        setupAdd()
        setupLayouts()
        
        authoView.delegate = self
        authoView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func setupAdd(){
        super.setupAdd()
        view.addSubview(authoView)
    }
    
    override func setupLayouts(){
        super.setupLayouts()
        NSLayoutConstraint.activate([
            authoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            authoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            authoView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}

extension AuthorizationViewController: AuthoViewDelegate {
   
    func signIn(with phoneNumber: String) {
        authService.signIn(with: phoneNumber) { result in
            switch result {
            case .success:
                let vc = MessageViewConroller()
                vc.phoneNumber = phoneNumber
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
                print("okay \(phoneNumber)")
            case .failure:
                self.showAlert(title: "Ошибка", massage: "Введен не правильный номер телефон!")
            }
        }
    }
}
