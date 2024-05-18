//
//  ResultSearchBarViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 11.5.2024.
//

import UIKit
import SnapKit

class ResultSearchBarViewController: BaseViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 10
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.dataSource = self
        return view
    }()
    
    private var products: [Meal] = []
    
    private var categories: [ProductCategory] = []
    
    private let networkService = NetworkService()
    
    override func setup() {
        super.setup()
        setupCollection()
        view.backgroundColor = .systemBackground
    }
    
    override func setupAdd() {
        super.setupAdd()
        view.add {
            collectionView
        }
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.register(
            ResultSearchBarCollectionViewCell.self,
            forCellWithReuseIdentifier: ResultSearchBarCollectionViewCell.reusID
        )
        collectionView.register(
            ResultCategorySeachBarCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: ResultCategorySeachBarCell.reusID)
    }
    
    func updateResults(with meals: [Meal]) {
        products = meals
        collectionView.reloadData()
        }
}

extension ResultSearchBarViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ResultSearchBarCollectionViewCell.reusID, 
            for: indexPath) as! ResultSearchBarCollectionViewCell
        cell.fill(with: products[indexPath.row])
        return cell
    }
     
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let categoryCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ResultCategorySeachBarCell.reusID, for: indexPath) as! ResultCategorySeachBarCell
        if !categories.isEmpty {
            categoryCell.fill(with: categories[indexPath.section])
        }
        return categoryCell
    }
}
