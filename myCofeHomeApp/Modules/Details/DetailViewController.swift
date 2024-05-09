//
//  DesertViewController.swift
//  myCofeHomeApp
//
//  Created by Apple on 26.4.2024.
//

import UIKit

class DetailViewController: BaseViewController {
    
    private let detailView = DetailView()
    
    private let networkService = NetworkService()
    
    var selectedProduct: String?
    
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func setup(){
        super.setup()
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
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupDetailsView() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
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
        dismiss(animated: true)

    }
    
    func buyBtn() {
        let vc = BascetViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
