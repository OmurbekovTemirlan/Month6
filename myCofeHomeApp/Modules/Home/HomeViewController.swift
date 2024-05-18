//
//  HomeViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private lazy var searchController: UISearchController = {
        let vcResult = ResultSearchBarViewController()
        let view = UISearchController(searchResultsController: vcResult)
        view.searchResultsUpdater = self
        view.obscuresBackgroundDuringPresentation = false
        view.searchBar.placeholder = "Поиск"
        view.searchBar.delegate = self
        return view
    }()
    
    private let categoriesCollectionView: UICollectionView = {
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
        label.text = ""
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productsCollectionView: UICollectionView = {
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
    
    
    private var counter = 0
    
    private var selectedHorizontalIndex = 0
    
    private let networkService = NetworkService()
    
    private var  productCategory: [ProductCategory] = []
    
    private var products: [Meal] = []
    
    private var selectedCategory: ProductCategory?
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupNavBar()
        setup()
        getCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    override func setup() {
        super.setup()
        setupAdd()
        setupLayouts()
        setupCollection()
        setupCollectionCounter()
    }
    
    override func setupAdd() {
        super.setupAdd()
        view.addSubview(categoriesCollectionView)
        view.addSubview(titleCategory)
        view.addSubview(productsCollectionView)
    }
    
    override func setupLayouts(){
        super.setupLayouts()
        NSLayoutConstraint.activate([
            
            categoriesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 60),
            
            titleCategory.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: 10),
            titleCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            productsCollectionView.topAnchor.constraint(equalTo: titleCategory.bottomAnchor, constant: 10),
            productsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            productsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    private func setupCollection() {
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.reusId)
        
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: ProductsCollectionViewCell.reusId)
    }
    
    private func setupNavBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.hidesBackButton = true
        let titleNavBar = "Меню"
        navigationItem.title = titleNavBar
        
        let belsBtn = UIBarButtonItem(image: UIImage(systemName: "bell.fill"), style: .plain, target: self, action: .none)
        navigationItem.rightBarButtonItem = belsBtn
        belsBtn.tintColor = .black
    }
    
    private func getCategories() {
        networkService.getCategories { [weak self] result in
            DispatchQueue.main.async { [weak self] in 
                guard let `self` else { return }
                switch result {
                case .success(let model):
                    self.productCategory = model
                    self.categoriesCollectionView.reloadData()
                    if let firstCategory = self.productCategory.first {
                        self.getProducts(with: firstCategory)
                        self.titleCategory.text = firstCategory.strCategory
                        self.productsCollectionView.reloadData()
                    }
                case .failure(let error):
                    showAlert(title: "error", massage: error.localizedDescription)
                }
            }
        }
    }
    
    private func getProducts(with category: ProductCategory) {
        networkService.getProducts(with: category.strCategory) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                switch result {
                case .success(let model):
                    self.products = model
                    self.productsCollectionView.reloadData()
                case .failure(let error):
                    showAlert(title: "Error", massage: error.localizedDescription)
                }
            }
        }
    }
    
    private func searchProducts(with title: String) {
           networkService.searchProducts(with: title) { [weak self] result in
               DispatchQueue.main.async {
                   guard let `self` = self, 
                            let resultsVC = self.searchController.searchResultsController
                            as? ResultSearchBarViewController else { return }
                   switch result {
                   case .success(let model):
                       resultsVC.updateResults(with: model)
                   case .failure:
                       resultsVC.updateResults(with: [])
                   }
               }
           }
       }
    
    private func setupCollectionCounter() {
        if let visibleCells = productsCollectionView.visibleCells as? [ProductsCollectionViewCell] {
            for cell in visibleCells {
                DispatchQueue.main.async {
                cell.counterChangedHandler = { [weak self] count in
                    self?.counter = count
                    print("count \(count)")
                    }
                }
            }
        }
    }
    
    private func handleProductDetailsTap(with product: Meal) {
        let detailVC = DetailViewController()
        detailVC.selectedProduct = product.idMeal
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.modalTransitionStyle = .flipHorizontal
        navigationController?.present(detailVC, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == categoriesCollectionView {
            productCategory.count
        } else {
            products.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoriesCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reusId, for: indexPath) as! CategoriesCollectionViewCell
            cell.fill(with: productCategory[indexPath.row])
            cell.backgroundColor = (indexPath.item == selectedHorizontalIndex) ? UIColor(named: "ColorItems") : .clear
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.reusId, for: indexPath) as! ProductsCollectionViewCell
            cell.fill(with: products[indexPath.row])
            return cell
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == categoriesCollectionView {
            selectedHorizontalIndex = indexPath.row
            categoriesCollectionView.reloadData()
            let selectedCategory = productCategory[indexPath.row]
            titleCategory.text = productCategory[indexPath.row].strCategory
            getProducts(with: selectedCategory)
        } else {
            handleProductDetailsTap(with: products[indexPath.row])
        }
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        searchProducts(with: text)
    }
}

extension HomeViewController: UISearchBarDelegate {
    
}
