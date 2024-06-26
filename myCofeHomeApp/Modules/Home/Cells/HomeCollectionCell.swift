//
//  HomeCollectionCell.swift
//  myCofeHomeApp
//
//  Created by Apple on 25.4.2024.
//

import UIKit

struct HomeCollectionStruct {
    var title: String
}

class HomeCollectionCell: UICollectionViewCell {
    
   private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup(){
        setupAdd()
        setupLayouts()
    }
    
    private func setupAdd(){
        addSubview(titleLabel)
    }
    
    private func setupLayouts(){
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func set(data: HomeCollectionStruct) {
        titleLabel.text = data.title
    }
    
}
