//
//  ProfileView.swift
//  myCofeHomeApp
//
//  Created by Apple on 10.5.2024.
//

import UIKit
import SnapKit

protocol ProfileViewDelegate: AnyObject {
    func exitButton()
}

class ProfileView: BaseView {
    
    private let exitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Выйти", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemCyan
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    weak var delegate: ProfileViewDelegate?
    
    override func setup() {
        super.setup()
        backgroundColor = .systemBrown
        
        exitButton.addTarget(self, action: #selector(exitButtonTap), for: .touchUpInside)
    }
    override func setupAdd() {
        super.setupAdd()
        add {
            exitButton
        }
    }
    override func setupLayouts() {
        super.setupLayouts()
        exitButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(25)
            make.size.equalTo(40)
        }
    }
    
    @objc
    func exitButtonTap() {
        delegate?.exitButton()
    }
}
