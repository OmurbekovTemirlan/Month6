//
//  DessertCollectionCell.swift
//  myCofeHomeApp
//
//  Created by Apple on 1.5.2024.
//

import UIKit

protocol DessertCollectionDelegate: AnyObject {
    
    func dessertCell(_ cell: DessertCollectionCell, didChangeCounterTo count: Int)
    
}

class DessertCollectionCell: UICollectionViewCell {
    
    weak var delegate: DessertCollectionDelegate?
    
    var counterChangedHandler: ((Int) -> Void)?
    
    private var counter = 0
    
    private var imageURL: URL?
    
    private let images: UIImageView = {
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(){
        setupAdd()
        setupLayouts()
    }
    
    private func setupAdd(){
        
        addSubview(images)
        addSubview(vStac)
        vStac.addArrangedSubview(titleLabel)
        vStac.addArrangedSubview(infoLabel)
        vStac.addArrangedSubview(priceLabel)
        addSubview(hStac)
        hStac.addArrangedSubview(minusBtn)
        hStac.addArrangedSubview(counterLabel)
        hStac.addArrangedSubview(plusBtn)
        
    }
    
    private func setupLayouts(){
        NSLayoutConstraint.activate([
            
            images.centerYAnchor.constraint(equalTo: centerYAnchor),
            images.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            images.heightAnchor.constraint(equalToConstant: 100),
            images.widthAnchor.constraint(equalToConstant: 100),
            
            vStac.centerYAnchor.constraint(equalTo: centerYAnchor),
            vStac.leadingAnchor.constraint(equalTo: images.trailingAnchor,constant: 15),
            vStac.heightAnchor.constraint(equalToConstant: 90),
            vStac.widthAnchor.constraint(equalToConstant: 135),
            
            hStac.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            hStac.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            hStac.heightAnchor.constraint(equalToConstant: 30),
            hStac.widthAnchor.constraint(equalToConstant: 100),
            
        ])
        
    }
    
    @objc private func plusTap(){
        counter += 1
        updateCounter()
    }
    
    @objc private func minusTap(){
        if counter > 0 {
            counter -= 1
            updateCounter()
        }
    }
    
    private func updateCounter() {
        counterLabel.text = "\(counter)"
        delegate?.dessertCell(self, didChangeCounterTo: counter)
        counterChangedHandler?(counter)
    }
    
    func fill(with item: ProductsMeals.Meal) {
       
        titleLabel.text = item.strMeal!
        priceLabel.text = "\(item.idMeal!) c"
        
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
                self.images.image = image
            }
        }
        task.resume()
    }
}
