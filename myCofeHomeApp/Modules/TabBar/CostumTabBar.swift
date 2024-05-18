//
//  CostumTabBar.swift
//  myCofeHomeApp
//
//  Created by Apple on 25.4.2024.
//

import UIKit

final class CostumTabBar: UITabBar {
    
     private let plusButton = QRCodeButton(type: .system)
     
     override func draw(_ rect: CGRect) {
         super.draw(rect)
         configueShape()
         
     }
    
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupTabBar()
         setupPlusButton()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     private func setupTabBar() {
         tintColor = UIColor(named: "yellow")
         unselectedItemTintColor = .black
     }
    
    private func setupPlusButton() {
        addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            plusButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            plusButton.centerYAnchor.constraint(equalTo: topAnchor),
            plusButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            plusButton.widthAnchor .constraint(equalTo: heightAnchor, multiplier: 0.6),
        ])
    }
    
    //MARK: - Hit Test
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        plusButton.frame.contains(point) ? plusButton : super.hitTest(point, with: event)
    }
     
 }

// MARK: - Draw Shape

extension CostumTabBar {
    
    private func configueShape() {
        
        let path = getTabBarPath()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor
        layer.insertSublayer(shape, at: 0)
        
    }
    
    private func getTabBarPath() -> UIBezierPath {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 100, y: 0))
        
        path.addArc(withCenter: CGPoint(x: frame.width / 2, y: 0),
                    radius: 30,
                    startAngle: .pi,
                    endAngle: .pi * 2,
                    clockwise: false)
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        
        return path
    }
    
}
