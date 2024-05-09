//
//  ProfileViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//

import UIKit
import SnapKit

class ProfileViewController: BaseViewController {
    
    private let profileView = ProfileView()
    
    private let sessionManager = UserSessionManager.shared
    
    override func setup() {
        super.setup()
        view.backgroundColor = .systemBackground
        profileView.delegate = self
    }
    override func setupAdd() {
        super.setupAdd()
        view.add {
            profileView
        }
    }
    override func setupLayouts() {
        super.setupLayouts()
        profileView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}

extension ProfileViewController: ProfileViewDelegate {
    func exitButton() {
        sessionManager.deleteSession()
        let vc = SplashViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
