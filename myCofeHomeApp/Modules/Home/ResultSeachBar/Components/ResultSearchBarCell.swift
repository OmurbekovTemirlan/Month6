//
//  ResultSearchBarCell.swift
//  myCofeHomeApp
//
//  Created by Apple on 11.5.2024.
//

import Foundation
import SnapKit

class ResultSearchBarCollectionViewCell: UICollectionViewCell, IScreenCalculatable {
    
    static let reusID = String(describing: ResultSearchBarCollectionViewCell.self)
    
    private let productImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    private let productCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "yellow")
        return label
    }()
    
    private let vStac = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupAdd()
        setupLayouts()
        setupVstac()
    }
    
    private func setupAdd() {
        
        add {
            productImageView
            productCategoryLabel
            vStac
        }
        vStac.addArrangedSubview(productTitleLabel)
        vStac.addArrangedSubview(productPriceLabel)
    }
    
    private func setupLayouts() {
        
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(230)
            make.width.equalTo(370)
        }
        productCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(15)
        }
        vStac.snp.makeConstraints { make in
            make.top.equalTo(productCategoryLabel.snp.bottom).offset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-5)
        }
       
    }
    
    private func setupVstac() {
        vStac.axis = .vertical
        vStac.distribution = .fillProportionally
        vStac.alignment = .leading
        vStac.spacing = 10
    }
    
    func fill(with item: Meal) {
        productCategoryLabel.text = "Категория: \(String(describing: item.strArea!))"
        productTitleLabel.text = item.strMeal
        productPriceLabel.text = "\(String(describing: item.idMeal!)) сом"
        ImageDownloader.shared.loadImage(from: item.strMealThumb!) { [weak self] result in
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    self?.productImageView.image = image
                }
            }
        }
    }
}
