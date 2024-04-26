//
//  SpalshViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 26.4.2024.
//

import UIKit

class SpalshViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if UserSessionManager.shared.isSessionActive {
            let vc = TabBarViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = AuthorizationViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
