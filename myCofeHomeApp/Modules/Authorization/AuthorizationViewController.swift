//
//  AuthorizationViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//
  
import UIKit

class AuthorizationViewController: UIViewController {
    
    private let authoView = AuthoView()
    
    private let sessionManager = UserSessionManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        
        setup()
    }

    private func setup(){
        setupAdd()
        setupLayouts()
        
        authoView.delegate = self
        authoView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupAdd(){
        view.addSubview(authoView)
    }
    
    private func setupLayouts(){
        NSLayoutConstraint.activate([
            authoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            authoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            authoView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}

extension AuthorizationViewController: AuthoViewDelegate {
    
    func toComeIn(with model: AuthoModel) {
        if sessionManager.isValid(phoneNumber: model.phoneNumber) {
           sessionManager.saveSession(phoneNumber: model.phoneNumber)
        let vc = TabBarViewController()
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
   
}
