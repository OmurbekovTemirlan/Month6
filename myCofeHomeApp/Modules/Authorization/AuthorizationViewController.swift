//
//  AuthorizationViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//
  
import UIKit

protocol AuthoViewDelegate: AnyObject {
    func signIn(with phoneNumber: AuthModel)
    func phoneNumberTfEdits(with text: UITextField)
}

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
    func phoneNumberTfEdits(with textField: UITextField) {
        
    }
   
    func signIn(with model: AuthModel) {
        authService.signIn(with: model.phoneNumber) { result in
            switch result {
            case .success(let data):
                let vc = SmsViewConroller()
                self.navigationController?.pushViewController(vc, animated: true)
                print("okay \(model.phoneNumber)")
            case .failure:
                self.showAlert(title: "Ошибка", massage: "Введен не правильный номер телефон!")
            }
        }
    }
}
