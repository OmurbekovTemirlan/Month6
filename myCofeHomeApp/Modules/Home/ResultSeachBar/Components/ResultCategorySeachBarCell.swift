//
//  ResultCategorySeachBarCell.swift
//  myCofeHomeApp
//
//  Created by Apple on 16.5.2024.
//

import UIKit
import SnapKit

class ResultCategorySeachBarCell: UICollectionViewCell, IScreenCalculatable {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        
    }
    
    private func setupAdd(){
        add {
          //  productImageView
            productCategoryLabel
        }
    }
    
    private func setupLayouts(){
//        productImageView.snp.makeConstraints { make in
//            make.directionalEdges.equalToSuperview()
//            make.height.equalTo(70)
//            make.width.equalTo(130)
//        }
        productCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).inset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5)
        }
    }
    func fill(with item: ProductCategory) {
        productCategoryLabel.text = item.strCategory
//        ImageDownloader.shared.loadImage(from: item.strCategoryThumb) { [weak self] result in
//            if case .success(let image) = result {
//                DispatchQueue.main.async {
//                    self?.productImageView.image = image
//                }
//            }
//        }
    }
}
