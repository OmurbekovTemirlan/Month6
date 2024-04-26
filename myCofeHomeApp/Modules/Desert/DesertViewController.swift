//
//  DesertViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 26.4.2024.
//

import UIKit

class DessertViewController: UIViewController {

    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "espesso")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
         let label = UILabel()
        label.text = "Эспрессо"
         label.font = .systemFont(ofSize: 16, weight: .regular)
         label.textColor = .black
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    
    }
    private func setup(){
        setupAdd()
        setupLayouts()
    }
    
    private func setupAdd(){
        view.addSubview(image)
    }
    
    private func setupLayouts(){
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 300)
        
        ])
    }

}
