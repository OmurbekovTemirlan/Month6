//
//  ResultSearchBarCell.swift
//  myCofeHomeApp
//
//  Created by Apple on 11.5.2024.
//

import Foundation
import SnapKit

class ResultSearchBarCollectionViewCell: UICollectionViewCell {
    
    private let productImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
         let label = UILabel()
         label.font = .systemFont(ofSize: 16, weight: .regular)
         label.textColor = .black
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    private let priceLabel: UILabel = {
         let label = UILabel()
         label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "yellow")
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}
