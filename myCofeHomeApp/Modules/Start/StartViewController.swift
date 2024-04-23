//
//  StartViewCOntroller.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//

import UIKit
 
class StartViewController: UIViewController {
    
    private let startView = StartView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setup()
        
    }
    
    private func setup(){
        
        setupAdd()
        setupLayouts()
        
        startView.delegate = self
        startView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupAdd(){
        
        view.addSubview(startView)
        
    }
    
    private func setupLayouts(){
        
        NSLayoutConstraint.activate([
            startView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            startView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            startView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
    }
    
}

extension StartViewController: StartViewDelegate {
    func toComeIn() {
        let vc = AuthorizationViewController()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
