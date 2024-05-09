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
      
        if UserSessionManager.shared.isSessionActive {
            let vc = TabBarViewController()
            vc.modalPresentationStyle = .fullScreen
            navigationController?.present(vc, animated: true)
        } else {
            let vc = EmailAuthoViewController()
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}
