//
//  TabBarViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCustomTabBar()
        setupTabItems()
        
       
    }
    
    private func setupNavBar() {
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        
        let titleNavBar = "Меню"
        
        navigationItem.title = titleNavBar
        
        let belsBtn = UIBarButtonItem(image: UIImage(systemName: "bell.fill"), style: .plain, target: self, action: .none)
        
        navigationItem.rightBarButtonItem = belsBtn
        
        belsBtn.tintColor = .black
        
    }
    
    private func setupCustomTabBar() {
        
        let customTabBar = CostumTabBar()
        setValue(customTabBar, forKey: "tabBar")
        
    }
    
    private func setupTabItems() {
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        
        let BascetVC = BascetViewController()
        BascetVC.tabBarItem.image = UIImage(systemName: "cart.fill")
        
        let catalogVC = CatalogViewController()
        catalogVC.tabBarItem.image = UIImage(systemName: "safari.fill")
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem.image = UIImage(systemName: "person.circle")
        
        setViewControllers([homeVC, BascetVC, catalogVC, profileVC], animated: false)
        
    }
    
    
    
    
}
