//
//  BaseViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 30.4.2024.
//

import UIKit

class BaseViewController: UIViewController, IScreenCalculatable {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        setupAdd()
        setupLayouts()
    }
    
    func setupAdd(){ }
    
    func setupLayouts(){ }
    
    func showAlert(title: String, massage: String){
        let alert = UIAlertController(title: title,
                                      message: massage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .destructive))
        self.present(alert, animated: true)
    }
    
}
