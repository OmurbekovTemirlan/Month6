//
//  BascetViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//

import UIKit
import SnapKit

class BascetViewController: BaseViewController {
    
    private lazy var productsCollectionView: UICollectionView = {
        let loyaut = UICollectionViewFlowLayout()
        loyaut.itemSize = CGSize(width: (UIScreen.main.bounds.width), height: 350)
        loyaut.minimumLineSpacing = 10
        loyaut.minimumInteritemSpacing = 15
        loyaut.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        loyaut.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: loyaut)
        collection.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.reusID
        )
        collection.showsVerticalScrollIndicator = false
        collection.refreshControl = refreshControll
        return collection
    }()
    
    private lazy var refreshControll: UIRefreshControl = {
        let controll = UIRefreshControl()
        controll.addTarget(self, action: #selector(reshreshProducts), for: .valueChanged)
        controll.attributedTitle = NSAttributedString(string: "Данные прогружается")
        return controll
    }()
    
    private lazy var activity: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.style = .large
        return view
    }()
    
    private var isLoading: Bool = false {
        didSet {
            _ = isLoading ? activity.startAnimating() : activity.stopAnimating()
        }
    }
    
    private var products: [ProductResponse.Product] = []
    
    private let networkService = NetworkService()
    
    private var skip = 0
    
    override func setup() {
        super.setup()
        getProducts()
        
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
    }
    
    override func setupAdd() {
        super.setupAdd()
        view.add {
            productsCollectionView
            activity
        }
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        productsCollectionView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.directionalVerticalEdges.equalToSuperview()
        }
        activity.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func getProducts() {
        isLoading = true
        networkService.fetchProducts(limit: 20, skip: skip * 10) { [weak self] result in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                sleep(1)
                self.isLoading = false
                if case .success(let products) = result {
                    self.products.append(contentsOf: products)
                    self.productsCollectionView.reloadData()
                }
            }
        }
    }
    
    @objc
    private func reshreshProducts() {
        skip = 0
        refreshControll.beginRefreshing()
        networkService.fetchProducts(limit: 20, skip: skip * 10) { [weak self] result in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                sleep(1)
                if case .success(let products) = result {
                    self.products.append(contentsOf: products)
                    self.productsCollectionView.reloadData()
                    self.refreshControll.endRefreshing()
                }
            }
        }
    }
}

extension BascetViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reusID, for: indexPath) as! ProductCollectionViewCell
        cell.fill(with: products[indexPath.row])
        return cell
    }
}

extension BascetViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath)
    {
        if indexPath.row == products.count - 1, !isLoading {
            skip += 1
            getProducts()
            
            
        }
    }
}
