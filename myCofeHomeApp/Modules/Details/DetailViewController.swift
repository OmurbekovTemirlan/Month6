//
//  DesertViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 26.4.2024.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func buyBtn()
    func backBtn()
}

class DetailViewController: BaseViewController {
    
    private let detailView = DetailView()
    
    private let networkService = NetworkService()
    
    var selectedProduct: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }
    
    override func setup(){
        super.setup()
        setupNavBar()
        setupAdd()
        setupLayouts()
        setupDetailsView()
        detailView.delegate = self
        getproducts(id: selectedProduct!)
    }
    
    override func setupAdd() {
        super.setupAdd()
        view.addSubview(detailView)
    }
    
    override func setupLayouts(){
        super.setupLayouts()
        NSLayoutConstraint.activate([
            
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupDetailsView() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupNavBar() {
        navigationItem.title = "Детали"
        navigationItem.hidesBackButton = true
    }
    
    private func getproducts(id: String) {
        networkService.getProductDetails(with: id) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.detailView.fill(with: model)
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
    
    func buyBtn() {
        let vc = BascetViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
