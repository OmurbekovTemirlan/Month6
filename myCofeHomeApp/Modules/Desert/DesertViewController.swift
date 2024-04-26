//
//  DesertViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 26.4.2024.
//

import UIKit

class DessertViewController: UIViewController {
    
    private let dessertView = DessertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }
    
    private func setup(){
        setupAdd()
        setupLayouts()
        setupDessertView()
    }
    
    private func setupAdd(){
        view.addSubview(dessertView)
    }
    
    private func setupLayouts(){
        
        NSLayoutConstraint.activate([
            
            dessertView.topAnchor.constraint(equalTo: view.topAnchor),
            dessertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            dessertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            dessertView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            
        ])
    }
    
    private func setupDessertView(){
        
        dessertView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
