//
//  BaseCollectionViewCell.swift
//  myCofeHomeApp
//
//  Created by Apple on 11.5.2024.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        setupAdd()
        setupLayouts()
    }
    
    func setupAdd(){
        
    }
    
    func setupLayouts(){
        
    }
}
