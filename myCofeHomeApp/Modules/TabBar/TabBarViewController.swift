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
        
        navigationItem.hidesBackButton = true
       
        navigationItem.title = "Меню"
        
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
        let homeNavCont = UINavigationController(rootViewController: homeVC)
        homeNavCont.tabBarItem.image = UIImage(systemName: "house")
        
        let BascetVC = BascetViewController()
        let bascetNavCont = UINavigationController(rootViewController: BascetVC)
        bascetNavCont.tabBarItem.image = UIImage(systemName: "cart.fill")
        
        let catalogVC = CatalogViewController()
        let catalogNavCont = UINavigationController(rootViewController: catalogVC)
        catalogNavCont.tabBarItem.image = UIImage(systemName: "safari.fill")
        
        let profileVC = ProfileViewController()
        let profileNavCont = UINavigationController(rootViewController: profileVC)
        profileNavCont.tabBarItem.image = UIImage(systemName: "person.circle")
        
        setViewControllers([homeNavCont, bascetNavCont, catalogNavCont, profileNavCont], animated: false)
        
    }
    
    
    
    
}
