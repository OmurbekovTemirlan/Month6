//
//  DessertView.swift
//  myCofeHomeApp
//
//  Created by Apple on 26.4.2024.
//

import UIKit
import SnapKit

protocol DetailViewControllerDelegate: AnyObject {
    func buyBtn()
    func backBtn()
}

class DetailView: BaseView {
    
    private let scrollView = UIScrollView()
    
    private let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.backgroundColor = UIColor(named: "yellow")
        btn.tintColor = .black
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    private let contentView = UIView()
    
    private let productImageView = UIImageView()
        
    private let scrolabelConteinerView = UIView()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "yellow")
        label.textAlignment = .right
        return label
    }()
    
    private let discriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let buyButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Купить", for: .normal)
        btn.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = UIColor(named: "yellow")
        btn.tintColor = .black
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    weak var delegate: DetailViewControllerDelegate?
    
    override func setup() {
        super.setup()
        backgroundColor = .white
        setupAdd()
        setupLayouts()
        someSettingsElememts()
    }
    
    func someSettingsElememts() {
        scrollView.delegate = self
        
        scrolabelConteinerView.backgroundColor = .white
        scrolabelConteinerView.layer.cornerRadius = 14
        scrolabelConteinerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        buyButton.addTarget(self, action: #selector(buyBtnTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    override func setupAdd() {
        super.setupAdd()
        add {
            scrollView
            backButton
        }
        scrollView.add { contentView }
        contentView.add {
            productImageView
            scrolabelConteinerView
        }
        scrolabelConteinerView.add {
            categoryLabel
            titleLabel
            priceLabel
            discriptionLabel
            buyButton
        }
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        backButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(26)
            make.size.equalTo(40)
        }
        
        scrollView.snp.makeConstraints { make in
            make.directionalEdges.width.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.directionalEdges.width.equalToSuperview()
        }
        productImageView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(320)
        }
        scrolabelConteinerView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(-25)
            make.bottom.directionalHorizontalEdges.equalToSuperview()
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.directionalHorizontalEdges.equalToSuperview().inset(15)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(12)
            make.leading.equalTo(categoryLabel)
            make.trailing.equalToSuperview().inset(100)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(12)
            make.trailing.equalToSuperview().inset(20)
        }
        discriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        buyButton.snp.makeConstraints { make in
            make.top.equalTo(discriptionLabel.snp.bottom).offset(30)
            make.directionalHorizontalEdges.equalTo(discriptionLabel)
            make.height.equalTo(45)
            make.bottom.equalToSuperview()
        }
        
    }
    
    func fill(with item: Meal) {
        titleLabel.text = item.strMeal
        categoryLabel.text = "Категория: \(String(describing: item.strArea!))"
        discriptionLabel.text = item.strInstructions
        priceLabel.text = "\(String(describing: item.idMeal!)) c"
        ImageDownloader.shared.loadImage(from: item.strMealThumb!) { [weak self] result in
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    self?.productImageView.image = image
                }
            }
        }
    }
    @objc
    private func backButtonTapped() {
        delegate?.backBtn()
    }
    @objc
    private func buyBtnTapped() {
        delegate?.buyBtn()
    }
}

extension DetailView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y

        let scaleFactor = max(1.0, 1.0 - (offsetY / productImageView.frame.height) * 0.3)
        guard scaleFactor.isFinite, scaleFactor > 0 else { return }
        productImageView.transform = CGAffineTransform(
            scaleX: scaleFactor, 
            y: scaleFactor).translatedBy(x: 0, y: -offsetY / 2)
        productImageView.frame.origin.y = offsetY
    
    }
}
