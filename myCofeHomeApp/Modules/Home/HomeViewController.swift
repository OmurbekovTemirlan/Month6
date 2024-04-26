//
//  HomeViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 24.4.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var selectedHorizontalIndex: Int?
    private var selectedVerticalIndex: Int?
    
    private var counter = 0
    
    private let idCell = "cell1"
    private let idCell2 = "cell2"
    
    private let titlesCells: [HomeCollectionStruct] =
    
    [
        
    HomeCollectionStruct(title: "Кофе"),
    HomeCollectionStruct(title: "Десерты"),
    HomeCollectionStruct(title: "Выпечка"),
    HomeCollectionStruct(title: "Коктейлы"),
    HomeCollectionStruct(title: "Коктейлы"),
   
    ]
    
    private let dates: [VerticalCollectionStruct] = 
    
    [
        
        VerticalCollectionStruct(
            image: "capp",
            title: "Капучино",
            infoLab: "Кофейный напиток",
            price: "150 c"),
        VerticalCollectionStruct(image: "espesso", title: "Эспрессо", infoLab: "Кофейный напиток", price: "100 c"),
        VerticalCollectionStruct(image: "amer", title: "Американо", infoLab: "Кофейный напиток", price: "120 c"),
        VerticalCollectionStruct(image: "latte", title: "Латте", infoLab: "Кофейный напиток", price: "100 с"),
        VerticalCollectionStruct(image: "mokko", title: "Мокко", infoLab: "Кофейный напиток", price: "150 с"),
        VerticalCollectionStruct(image: "Raf", title: "Раф", infoLab: "Кофейный напиток", price: "90 с"),
        VerticalCollectionStruct(image: "Fredo", title: "Фредо", infoLab: "Кофейный напиток", price: "100 с"),
        
    ]
    
    private let homeCollectionViewHorizontal: UICollectionView = {
        let loyaut = UICollectionViewFlowLayout()
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
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setup(){
        setupAdd()
        setupLayouts()
        setupCollection()
      setupCollectionCounter()
    }
    
    private func setupAdd(){
        view.addSubview(homeCollectionViewHorizontal)
        view.addSubview(titleCategory)
        view.addSubview(homeCollectionViewVertical)
    }
    
    private func setupLayouts(){
        
        NSLayoutConstraint.activate([
            
            homeCollectionViewHorizontal.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
    
    private func setupCollectionCounter() {
            
            if let visibleCells = homeCollectionViewVertical.visibleCells as? [VerticalCollectionViewCell] {
                
                for cell in visibleCells {
                  
                    cell.counterChangedHandler = { [weak self] count in
                       
                        self?.counter = count
                       
                    }
                }
            }
        }
    
    private func navigateToDessertsScreen() {
           let dessertsVC = DessertViewController()
        navigationController?.pushViewController(dessertsVC, animated: true)
       }
    
    @objc
    private func belsBtnTap() {
        
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == homeCollectionViewHorizontal {
            titlesCells.count
        } else {
            dates.count
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == homeCollectionViewHorizontal {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell, for: indexPath) as! HomeCollectionCell
            cell.set(data: titlesCells[indexPath.row])
            cell.backgroundColor = (indexPath.item == selectedHorizontalIndex) ? UIColor(named: "ColorItems") : .clear
            cell.layer.cornerRadius = 13
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell2, for: indexPath) as! VerticalCollectionViewCell
            cell.set(dates: dates[indexPath.row])
            return cell
        }
        
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == homeCollectionViewHorizontal {
            
            selectedHorizontalIndex = indexPath.item
            
            homeCollectionViewHorizontal.reloadData()
            
        } else {
            if indexPath.item == 1 {
                navigateToDessertsScreen()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
        if collectionView == homeCollectionViewHorizontal {
            return CGSize(width: 100, height: 30)
        } else {
            return CGSize(width: (UIScreen.main.bounds.width), height: 120)
        }
        
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    
        if collectionView == homeCollectionViewHorizontal {
            return 10
        } else {
            return 15
        }
           
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           
            if collectionView == homeCollectionViewHorizontal {
                return 20
            } else {
               return 10
            }
           
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

            if collectionView == homeCollectionViewHorizontal {
                return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            } else {
                return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
            }
            
        }
    
}

