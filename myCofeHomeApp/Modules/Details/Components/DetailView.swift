//
//  DessertView.swift
//  myCofeHomeApp
//
//  Created by Apple on 26.4.2024.
//

import UIKit
import SnapKit

class DetailView: BaseView {

    weak var delegate: DetailViewControllerDelegate?
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let backbtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.backgroundColor = UIColor(named: "yellow")
        btn.tintColor = .black
        btn.layer.cornerRadius = 20
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "yellow")
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buyBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("BUY", for: .normal)
        btn.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = UIColor(named: "yellow")
        btn.tintColor = .black
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func setup(){
        super.setup()
        backgroundColor = .white
        layer.cornerRadius = 25
        
        setupAdd()
        setupLayouts()
        
        backbtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        buyBtn.addTarget(self, action: #selector(buyBtnTapped), for: .touchUpInside)
    }
    
    override func setupAdd(){
        super.setupAdd()
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(image)
        contentView.addSubview(backbtn)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(buyBtn)
    }
    
    override func setupLayouts(){
        super.setupLayouts()
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 320),
            
            backbtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            backbtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backbtn.heightAnchor.constraint(equalToConstant: 40),
            backbtn.widthAnchor.constraint(equalToConstant: 40),
            
            categoryLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            
            priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 15),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
           
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
           
            buyBtn.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            buyBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            buyBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            buyBtn.heightAnchor.constraint(equalToConstant: 45),
            buyBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
        ])
    }
    
    func fill(with item: Meal) {
        titleLabel.text = item.strMeal
        categoryLabel.text = "Категория: \(String(describing: item.strArea!))"
        infoLabel.text = item.strInstructions
        priceLabel.text = "\(String(describing: item.idMeal!)) c"
        ImageDownloader.shared.loadImage(from: item.strMealThumb!) { [weak self] result in
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    self?.image.image = image
                }
            }
        }
    }
    
    @objc
    private func backBtnTapped() {
        delegate?.backBtn()
    }
    
    @objc
    private func buyBtnTapped() {
        delegate?.buyBtn()
    }
}
