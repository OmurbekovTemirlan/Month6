//
//  VerticalCollectionViewCell.swift
//  myCofeHomeApp
//
//  Created by Apple on 25.4.2024.
//

import UIKit

protocol VerticalCollectionViewCellDelegate: AnyObject {
    func verticalCollectionViewCell(_ cell: ProductsCollectionViewCell, didChangeCounterTo count: Int)
}


class ProductsCollectionViewCell: UICollectionViewCell {
    
    private let productImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let vStac: UIStackView = {
        let stac = UIStackView()
        stac.axis = .vertical
        stac.distribution = .fillEqually
        stac.translatesAutoresizingMaskIntoConstraints = false
        return stac
    }()
    
   private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productDiscriptionLabel: UILabel = {
         let label = UILabel()
         label.font = .systemFont(ofSize: 14, weight: .regular)
         label.textColor = .black
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    private let productPriceLabel: UILabel = {
         let label = UILabel()
         label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "yellow")
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    private let hStac: UIStackView = {
        let stac = UIStackView()
        stac.axis = .horizontal
        stac.distribution = .fillEqually
        stac.translatesAutoresizingMaskIntoConstraints = false
        return stac
    }()
    
    private let plusBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor(named: "yellow")
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(plusTap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minusBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "minus"), for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .systemGray4
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(minusTap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var imageURL: URL?
    
    static let reusId = String(stringLiteral: "ProductsCollectionViewCell.reusId")
    
    weak var delegate: VerticalCollectionViewCellDelegate?
    
    var counterChangedHandler: ((Int) -> Void)?
    
    var counter = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        backgroundColor = .systemGray6
        layer.cornerRadius = 12
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "yellow")?.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(){
        setupAdd()
        setupLayouts()
    }
    
    private func setupAdd(){
        
        addSubview(productImageView)
        addSubview(vStac)
        vStac.addArrangedSubview(productTitleLabel)
        vStac.addArrangedSubview(productDiscriptionLabel)
        vStac.addArrangedSubview(productPriceLabel)
        addSubview(hStac)
        hStac.addArrangedSubview(minusBtn)
        hStac.addArrangedSubview(counterLabel)
        hStac.addArrangedSubview(plusBtn)
        
    }
    
    private func setupLayouts(){
        NSLayoutConstraint.activate([
            productImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            
            vStac.centerYAnchor.constraint(equalTo: centerYAnchor),
            vStac.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor,constant: 10),
            vStac.heightAnchor.constraint(equalToConstant: 90),
            vStac.widthAnchor.constraint(equalToConstant: 170),
            
            hStac.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            hStac.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            hStac.heightAnchor.constraint(equalToConstant: 30),
            hStac.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc 
    private func plusTap(){
        counter += 1
        updateCounter()
    }
    
    @objc 
    private func minusTap(){
        if counter > 0 {
            counter -= 1
        }
        updateCounter()
    }
    
    private func updateCounter() {
        counterLabel.text = "\(counter)"
        delegate?.verticalCollectionViewCell(self, didChangeCounterTo: counter)
        counterChangedHandler?(counter)
    }
    
    func fill(with item: Meal) {
        productTitleLabel.text = item.strMeal!
        productPriceLabel.text = "\(item.idMeal!) c"
        if let imageURL = URL(string: item.strMealThumb ?? "") {
            self.imageURL = imageURL
            loadImage()
        }
    }
    
    private func loadImage(){
        
        guard let imageURL = imageURL else {return}
        
        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                print("Ошибка загрузки изображения:", error?.localizedDescription ?? "Unknown error")
                return
            }
            DispatchQueue.main.async {
                self.productImageView.image = image
            }
        }
        task.resume()
    }
}
