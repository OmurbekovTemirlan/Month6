//
//  ProductCollectionViewCell.swift
//  myCofeHomeApp
//
//  Created by Apple on 11.5.2024.
//

import UIKit
import SnapKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    private let productImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let productDiscriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "yellow")
        return label
    }()
    
    private let productRatingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "yellow")
        return label
    }()
    
    private let productBrandLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "yellow")
        return label
    }()
    
    static let reusID = "reusID"
    
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
        backgroundColor = .clear
    }
    
    private func setupAdd() {
        add {
            productImageView
            productBrandLabel
            productTitleLabel
            productDiscriptionLabel
            productPriceLabel
            productRatingLabel
        }
    }
    
    private func setupLayouts() {
        productImageView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.top.equalToSuperview()
            make.height.equalTo(200)
        }
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(130)
        }
        productBrandLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(15)
            make.trailing.equalToSuperview().inset(20)
        }
        productDiscriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(productBrandLabel.snp.bottom).offset(15)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        productPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(productDiscriptionLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        productRatingLabel.snp.makeConstraints { make in
            make.top.equalTo(productDiscriptionLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    func fill(with item: ProductResponse.Product) {
        productTitleLabel.text = item.title
        productBrandLabel.text = item.brand
        productDiscriptionLabel.text = item.description
        productPriceLabel.text = String("\(item.price) $")
        productRatingLabel.text = String("Рейтинг: \(item.rating)")
        ImageDownloader.shared.loadImage(from: item.thumbnail) { [ weak self ] result in
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    self?.productImageView.image = image
                }
            }
        }
    }
}
