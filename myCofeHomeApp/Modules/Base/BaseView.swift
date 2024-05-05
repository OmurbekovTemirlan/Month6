//
//  BaseView.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
     func setup(){
        setupAdd()
        setupLayouts()
    }
     
     func setupAdd() { }
    
     func setupLayouts() { }
    
}
