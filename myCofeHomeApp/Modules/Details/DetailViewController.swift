//
//  DesertViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 26.4.2024.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func backBtn()
}

class DetailViewController: BaseViewController {
    
    private let dessertView = DetailView()
    
    private let networkService = NetworkService()
    
    var selectedProduct: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem?.title = ""
        setup()
    }
    
    override func setup(){
        super.setup()
        setupAdd()
        setupLayouts()
        setupDessertView()
        loadDates(id: selectedProduct!)
        
    }
    
    override func setupAdd() {
        super.setupAdd()
        view.addSubview(dessertView)
    }
    
    override func setupLayouts(){
        super.setupLayouts()
        NSLayoutConstraint.activate([
            
            dessertView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dessertView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dessertView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dessertView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupDessertView() {
        dessertView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func loadDates(id: String) {
        networkService.getProductDetails(with: id) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.dessertView.fill(with: model)
                }
            case .failure(let error):
                showAlert(title: "error", massage: error.localizedDescription)
            }
        }
    }
}

extension DetailViewController: DetailViewControllerDelegate {
    func backBtn() {
        navigationController?.popViewController(animated: true)
    }
}
