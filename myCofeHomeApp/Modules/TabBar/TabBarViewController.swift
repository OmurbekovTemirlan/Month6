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
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        
        let bascetVC = BascetViewController()
        let bascetNavVC = UINavigationController(rootViewController: bascetVC)
        bascetVC.tabBarItem.image = UIImage(systemName: "cart.fill")
        
        let catalogVC = CatalogViewController()
        let catalogNavVC = UINavigationController(rootViewController: catalogVC)
        catalogVC.tabBarItem.image = UIImage(systemName: "safari.fill")
        
        let profileVC = ProfileViewController()
        let profileNavVC = UINavigationController(rootViewController: profileVC)
        profileVC.tabBarItem.image = UIImage(systemName: "person.circle")
        
        setViewControllers([homeNavVC, bascetNavVC, catalogNavVC, profileNavVC], animated: false)
        
    }
    
    
    
    
}
