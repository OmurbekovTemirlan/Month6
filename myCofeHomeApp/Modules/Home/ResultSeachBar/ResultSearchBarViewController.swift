//
//  ResultSearchBarViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 11.5.2024.
//

import UIKit
import SnapKit

class ResultSearchBarViewController: BaseViewController {
    
    private let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Поиск"
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.layer.cornerRadius = 13
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let productsCollectionView: UICollectionView = {
        let loyaut = UICollectionViewFlowLayout()
        loyaut.itemSize = CGSize(width: (UIScreen.main.bounds.width), height: 120)
        loyaut.minimumLineSpacing = 10
        loyaut.minimumInteritemSpacing = 15
        loyaut.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        loyaut.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: loyaut)
        collection.backgroundColor = .systemCyan
        return collection
    }()
    
    override func setup() {
        super.setup()
        view.backgroundColor = .systemBackground
        navigationItem.titleView = searchBar
        
    }
    override func setupAdd() {
        super.setupAdd()
        view.add {
            searchBar
            productsCollectionView
        }
    }
    override func setupLayouts() {
        super.setupLayouts()
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.size.equalTo(45)
        }
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.bottom.directionalHorizontalEdges.equalToSuperview()
        }
    }
}

//extension ResultSearchBarViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    
//    
//}
