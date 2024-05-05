//
//  AuthorizationViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//
  
import UIKit

protocol AuthoViewDelegate: AnyObject {
    func isvalidateTF(text: UITextField)
    func signIn()
}

class AuthorizationViewController: BaseViewController {
    
    private let authoView = AuthoView()
    
    private let sessionManager = UserSessionManager.shared
    
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
    func isvalidateTF(text: UITextField) {
        guard let phoneNumber = text.text else { return }
        if sessionManager.isValid(phoneNumber: phoneNumber){
            sessionManager.saveSession(phoneNumber: phoneNumber)
        }
    }
    
    func signIn() {
            let vc = SmsViewConroller()
                navigationController?.pushViewController(vc, animated: true)
    }
}
