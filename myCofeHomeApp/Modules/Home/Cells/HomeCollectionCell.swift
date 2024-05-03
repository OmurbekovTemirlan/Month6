//
//  HomeCollectionCell.swift
//  myCofeHomeApp
//
//  Created by Apple on 25.4.2024.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {
    
   private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        layer.cornerRadius = 13
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
    
    func fill(with item: ProductsCategories.ProductCategory) {
        titleLabel.text = item.strCategory
    }
    
}
