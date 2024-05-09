//
//  UIView + Extension.swift
//  myCofeHomeApp
//
//  Created by Apple on 9.5.2024.
//

import UIKit

extension UIView {
    @resultBuilder
    struct SubviewBuilder {
        static func buildBlock(_ components: UIView...) -> [UIView] { components }
    }
    
    func add(@SubviewBuilder _ components: () -> [UIView]) {
        components().forEach(addSubview)
    }
}
