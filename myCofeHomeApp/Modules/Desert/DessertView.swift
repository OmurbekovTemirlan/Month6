//
//  DessertView.swift
//  myCofeHomeApp
//
//  Created by Apple on 26.4.2024.
//

import UIKit

protocol DessertViewDelegate: AnyObject {
    
    func dessertView(_ cell: DessertView, didChangeCounterTo count: Int)

}

class DessertView: BaseView {
    
    var delegate: DessertViewDelegate?
    
    var counterChangedHandler: ((Int) -> Void)?
    
    private var counter = 0
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "espesso")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let hStacForLabels: UIStackView = {
        let stac = UIStackView()
        stac.axis = .horizontal
        stac.distribution = .fillEqually
        stac.translatesAutoresizingMaskIntoConstraints = false
        return stac
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Эспрессо"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "100 c"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "yellow")
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Брауни - шоколадное пирожное коричневого цвета прямоугольные куски нарезанного шоколадный пирожный"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 3
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
        btn.layer.cornerRadius = 18
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
        btn.layer.cornerRadius = 18
        btn.addTarget(self, action: #selector(minusTap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    
    override func setup(){
        super.setup()
        
        setupAdd()
        setupLayouts()
        
    }
    
    override func setupAdd(){
        super.setupAdd()
        
        addSubview(image)
        addSubview(hStacForLabels)
        hStacForLabels.addArrangedSubview(titleLabel)
        hStacForLabels.addArrangedSubview(priceLabel)
        addSubview(infoLabel)
        addSubview(hStac)
        hStac.addArrangedSubview(minusBtn)
        hStac.addArrangedSubview(counterLabel)
        hStac.addArrangedSubview(plusBtn)
    }
    
    override func setupLayouts(){
        super.setupLayouts()
        
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 300),
            
            hStacForLabels.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            hStacForLabels.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            hStacForLabels.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hStacForLabels.heightAnchor.constraint(equalToConstant: 30),
           
            infoLabel.topAnchor.constraint(equalTo: hStacForLabels.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            hStac.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            hStac.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            hStac.heightAnchor.constraint(equalToConstant: 36),
            hStac.widthAnchor.constraint(equalToConstant: 110),
            
        ])
    }
    @objc private func plusTap(){
        counter += 1
        updateCounter()
        print("count \(counter)")
    }
    
    @objc private func minusTap(){
        if counter > 0 {
            counter -= 1
            updateCounter()
            print("count \(counter)")
        }
    }
    
    private func updateCounter() {
        counterLabel.text = "\(counter)"
        delegate?.dessertView(self, didChangeCounterTo: counter)
        counterChangedHandler?(counter)
    }
    
}
