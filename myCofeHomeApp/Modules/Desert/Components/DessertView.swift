//
//  DessertView.swift
//  myCofeHomeApp
//
//  Created by Apple on 26.4.2024.
//

import UIKit

protocol DessertViewDelegate: AnyObject {
    
    func dessertView(_ cell: DessertView, didChangeCounterTo count: Int)

}

class DessertView: BaseView {
    
    private var products: [ProductsMeals.Meal] = []
    
    private let parser = JsonParser()
    
   weak var delegate: DessertViewDelegate?
    
    private let networkService = NetworkService()
    
    var counterChangedHandler: ((Int) -> Void)?
    
    private var counter = 0
    
    var selectedProduct: ProductsMeals.Meal?
    
    private let idCell3 = "cell3"
    
    private let hStacForLabels: UIStackView = {
        let stac = UIStackView()
        stac.axis = .horizontal
        stac.distribution = .fillEqually
        stac.translatesAutoresizingMaskIntoConstraints = false
        return stac
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Эспрессо"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "100 c"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "yellow")
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "123456789"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hStac: UIStackView = {
        let stac = UIStackView()
        stac.axis = .horizontal
        stac.distribution = .fillEqually
        stac.translatesAutoresizingMaskIntoConstraints = false
        return stac
    }()
    
    private let plusBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor(named: "yellow")
        btn.layer.cornerRadius = 18
        btn.addTarget(self, action: #selector(plusTap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minusBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "minus"), for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .systemGray4
        btn.layer.cornerRadius = 18
        btn.addTarget(self, action: #selector(minusTap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let recommendedProductLabel: UILabel = {
        let label = UILabel()
        label.text = "Приятное дополнение"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let recommendedProductsCollectionView: UICollectionView = {
        let loyaut = UICollectionViewFlowLayout()
        loyaut.itemSize = CGSize(width: (UIScreen.main.bounds.width), height: 120)
        loyaut.minimumLineSpacing = 10
        loyaut.minimumInteritemSpacing = 15
        loyaut.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        loyaut.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: loyaut)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .systemBackground
        return collection
    }()

    
    override func setup(){
        super.setup()
        backgroundColor = .white
        
        setupAdd()
        setupLayouts()
        setupCollection()
        setupData()
        
        
        layer.cornerRadius = 25
    }
    
    override func setupAdd(){
        super.setupAdd()
        
        addSubview(hStacForLabels)
        hStacForLabels.addArrangedSubview(titleLabel)
        hStacForLabels.addArrangedSubview(priceLabel)
        addSubview(infoLabel)
        addSubview(hStac)
        hStac.addArrangedSubview(minusBtn)
        hStac.addArrangedSubview(counterLabel)
        hStac.addArrangedSubview(plusBtn)
        addSubview(recommendedProductsCollectionView)
        addSubview(recommendedProductLabel)
    }
    
    override func setupLayouts(){
        super.setupLayouts()
        
        NSLayoutConstraint.activate([
            
            hStacForLabels.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            hStacForLabels.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            hStacForLabels.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            hStacForLabels.heightAnchor.constraint(equalToConstant: 30),
           
            infoLabel.topAnchor.constraint(equalTo: hStacForLabels.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            infoLabel.trailingAnchor.constraint(equalTo: hStac.leadingAnchor, constant: -10),
            
            hStac.topAnchor.constraint(equalTo: hStacForLabels.bottomAnchor, constant: 10),
            hStac.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            hStac.heightAnchor.constraint(equalToConstant: 36),
            hStac.widthAnchor.constraint(equalToConstant: 110),
            
            recommendedProductLabel.topAnchor.constraint(equalTo: hStac.bottomAnchor, constant: 10),
            recommendedProductLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            recommendedProductsCollectionView.topAnchor.constraint(equalTo: recommendedProductLabel.bottomAnchor, constant: 10),
            recommendedProductsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            recommendedProductsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            recommendedProductsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupCollection() {
        
        recommendedProductsCollectionView.dataSource = self
        recommendedProductsCollectionView.register(DessertCollectionCell.self, forCellWithReuseIdentifier: idCell3)
        
    }
    
    private func getProducts(Category: String) {
        networkService.getProducts(with: Category) { [weak self] result in
            DispatchQueue.main.async { [weak self] in guard let self = self else { return }
                switch result {
                case .success(let model):
                    self.products = model
                    self.recommendedProductsCollectionView.reloadData()
                case .failure(let error):
                    showAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
     func setupData() {
         
         if let product = selectedProduct {
             titleLabel.text = product.strMeal
             priceLabel.text = "\(String(describing: product.idMeal ?? "")) c"
             infoLabel.text = product.strArea ?? "No area provided"
             getProducts(Category: product.idMeal ?? "53071")
         }
    }
    
    @objc private func plusTap() {
        counter += 1
        updateCounter()
        print("count \(counter)")
    }
    
    @objc private func minusTap() {
        if counter > 0 {
            counter -= 1
            updateCounter()
            print("count \(counter)")
        }
    }
    
    private func updateCounter() {
        counterLabel.text = "\(counter)"
        delegate?.dessertView(self, didChangeCounterTo: counter)
        counterChangedHandler?(counter)
    }
    
}

extension DessertView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell3, for: indexPath) as! DessertCollectionCell
        cell.fill(with: products[indexPath.row])
        return cell
    }
}

extension UIView {
    func showAlert(title: String, message: String) {
        if let viewController = self.next as? UIViewController {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive))
            viewController.present(alert, animated: true)
        }
    }
}
