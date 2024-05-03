//
//  DesertViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 26.4.2024.
//

import UIKit

class DessertViewController: BaseViewController {
    
    var selectedProduct: ProductsMeals.Meal?
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "espesso")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var imageURL: URL?
    
    private lazy var leftBackBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor(named: "yellow")
        btn.layer.cornerRadius = 18
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let dessertView = DessertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        setup()
        
        leftBackBtn.addTarget(self, action: #selector(leftBackBtnTap), for: .touchUpInside)
        
    }
    
    override func setup(){
        super.setup()
        setupAdd()
        setupLayouts()
        setupDessertView()
        setupData()
        
    }
    
    override func setupAdd() {
        super.setupAdd()
        view.addSubview(image)
        view.addSubview(leftBackBtn)
        view.addSubview(dessertView)
        
    }
    
    override func setupLayouts(){
        super.setupLayouts()
        
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 300),
            
            leftBackBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            leftBackBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leftBackBtn.heightAnchor.constraint(equalToConstant: 36),
            leftBackBtn.widthAnchor.constraint(equalToConstant: 36),
            
            dessertView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -30),
            dessertView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dessertView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dessertView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    private func setupDessertView(){

        dessertView.translatesAutoresizingMaskIntoConstraints = false
        
        dessertView.selectedProduct = selectedProduct
        dessertView.setupData()
    }
    
    private func setupData() {
        guard let product = selectedProduct,
              let imageName = product.strMealThumb else { return }
        
        if let imageURL = URL(string: product.strMealThumb ?? "") {
            self.imageURL = imageURL
            loadImage()
            
        }
    }
    
    private func loadImage(){
        
        guard let imageURL = imageURL else {return}
        
        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                print("Ошибка загрузки изображения:", error?.localizedDescription ?? "Unknown error")
                return
            }
            DispatchQueue.main.async {
                self.image.image = image
            }
        }
        task.resume()
    }
    
    
    @objc
    private func leftBackBtnTap() {
        
        navigationController?.popViewController(animated: true)
        
    }
    
}
