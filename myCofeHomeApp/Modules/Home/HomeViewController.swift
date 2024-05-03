//
//  HomeViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private var selectedHorizontalIndex: Int?
    
    private var selectedProduct: ProductsMeals.Meal?
    
    private var counter = 0
    
    private let idCell = "cell1"
    private let idCell2 = "cell2"
    
    private let parser = JsonParser()
    
    private let networkService = NetworkService()
    
    private var  categoriess: [ProductsCategories.ProductCategory] = []
    
    private var products: [ProductsMeals.Meal] = []
    
    private let searchBar: UISearchTextField = {
        let view = UISearchTextField()
        view.placeholder = "Поиск"
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.layer.cornerRadius = 13
        view.backgroundColor = UIColor.clear
//        view.addTarget(self, action: #selector(searchBarEditing), for: .editingChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let homeCollectionViewHorizontal: UICollectionView = {
        let loyaut = UICollectionViewFlowLayout()
        loyaut.itemSize = CGSize(width: 100, height: 30)
        loyaut.minimumLineSpacing = 20
        loyaut.minimumInteritemSpacing = 10
        loyaut.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        loyaut.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: loyaut)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .systemBackground
        return collection
    }()
    
    private let titleCategory: UILabel = {
        let label = UILabel()
        label.text = "Кофе"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let homeCollectionViewVertical: UICollectionView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setup()
        getCategoriesNet()
        defaultScreen()
        
    }
    
    override func setup(){
        super.setup()
        setupAdd()
        setupLayouts()
        setupCollection()
        setupCollectionCounter()
    }
    
    override func setupAdd(){
        super.setupAdd()
        view.addSubview(searchBar)
        view.addSubview(homeCollectionViewHorizontal)
        view.addSubview(titleCategory)
        view.addSubview(homeCollectionViewVertical)
        
    }
    
    override func setupLayouts(){
        super.setupLayouts()
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            homeCollectionViewHorizontal.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            homeCollectionViewHorizontal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            homeCollectionViewHorizontal.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            homeCollectionViewHorizontal.heightAnchor.constraint(equalToConstant: 60),
            
            titleCategory.topAnchor.constraint(equalTo: homeCollectionViewHorizontal.bottomAnchor, constant: 10),
            titleCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            homeCollectionViewVertical.topAnchor.constraint(equalTo: titleCategory.bottomAnchor, constant: 10),
            homeCollectionViewVertical.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            homeCollectionViewVertical.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            homeCollectionViewVertical.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    private func setupCollection() {
        
        homeCollectionViewHorizontal.dataSource = self
        homeCollectionViewHorizontal.delegate = self
        homeCollectionViewHorizontal.register(HomeCollectionCell.self, forCellWithReuseIdentifier: idCell)
        
        homeCollectionViewVertical.dataSource = self
        homeCollectionViewVertical.delegate = self
        homeCollectionViewVertical.register(VerticalCollectionViewCell.self, forCellWithReuseIdentifier: idCell2)
        
    }
    
    private func getCategoriesNet() {
        networkService.getCategories { [weak self] result in
            DispatchQueue.main.async { [weak self] in guard let self else { return }
                switch result {
                case .success(let model):
                    self.categoriess = model
                    self.homeCollectionViewHorizontal.reloadData()
                case .failure(let error):
                    showAlert(title: "error", massage: error.localizedDescription)
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
    
    private func getProductsNet(forCategory category: String) {
        networkService.getProducts(with: category) { [weak self] result in
            DispatchQueue.main.async { [weak self] in guard let self = self else { return }
                switch result {
                case .success(let model):
                    self.products = model
                    self.homeCollectionViewVertical.reloadData()
                case .failure(let error):
                    showAlert(title: "Error", massage: error.localizedDescription)
                }
            }
        }
    }


    private func defaultScreen(){
        
        selectedHorizontalIndex = 1
        
        if let selectedCategory = categoriess.first?.strCategory {
            updateDataForVerticalCollectionView(with: selectedCategory)
            
        }
    }
    
    private func updateDataForVerticalCollectionView(with categoryName: String) {
        
      
            getProductsNet(forCategory: categoryName)
            homeCollectionViewVertical.reloadData()
       
    }
    
    private func setupCollectionCounter() {
        
        if let visibleCells = homeCollectionViewVertical.visibleCells as? [VerticalCollectionViewCell] {
            
            for cell in visibleCells {
                
                cell.counterChangedHandler = { [weak self] count in
                    
                    self?.counter = count
                    
                }
            }
        }
    }
    
    private func navigateToDessertsScreen(with product: ProductsMeals.Meal) {
        
        let dessertsVC = DessertViewController()
        dessertsVC.selectedProduct = selectedProduct
        navigationController?.pushViewController(dessertsVC, animated: true)
        
    }
    
    @objc
    private func belsBtnTap() {
        
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == homeCollectionViewHorizontal {
            categoriess.count
        } else {
            products.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == homeCollectionViewHorizontal {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell, for: indexPath) as! HomeCollectionCell
            cell.fill(with: categoriess[indexPath.row])
            cell.backgroundColor = (indexPath.item == selectedHorizontalIndex) ? UIColor(named: "ColorItems") : .clear
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell2, for: indexPath) as! VerticalCollectionViewCell
            cell.fill(with: products[indexPath.row])
            return cell
        }
        
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == homeCollectionViewHorizontal {
            
            let selectedCategory = categoriess[indexPath.row].strCategory
            
            updateDataForVerticalCollectionView(with: selectedCategory)
            
            selectedHorizontalIndex = indexPath.item
            
            homeCollectionViewHorizontal.reloadData()
            
        } else {
                
            selectedProduct = products[indexPath.row]

            navigateToDessertsScreen(with: selectedProduct!)
                
        }
    }
}
