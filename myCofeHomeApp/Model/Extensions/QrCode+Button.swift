//
//  UIButton.swift
//  myCofeHomeApp
//
//  Created by Apple on 25.4.2024.
//

import UIKit

final class QRCodeButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setImage(UIImage(systemName: "qrcode"), for: .normal)
        tintColor = .white
        backgroundColor = UIColor(named: "yellow")
        translatesAutoresizingMaskIntoConstraints = false
    }
}
