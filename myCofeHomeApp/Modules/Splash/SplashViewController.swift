//
//  SpalshViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 26.4.2024.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
      showScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showScreen()
    }
    
    private func showScreen() {
        if UserSessionManager.shared.isSessionActive {
            let vc = TabBarViewController()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            navigationController?.present(navVC, animated: true)
        } else {
            let vc = EmailAuthoViewController()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            navigationController?.present(navVC, animated: false)
        }
    }
}
