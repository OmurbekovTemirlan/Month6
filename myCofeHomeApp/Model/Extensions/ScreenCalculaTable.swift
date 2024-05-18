//
//  ScreenCalculaTable.swift
//  myCofeHomeApp
//
//  Created by Apple on 15.5.2024.
//

import UIKit

protocol IScreenCalculatable {
    func widthComputed(_ value: CGFloat) -> CGFloat
    func heightComputed(_ value: CGFloat) -> CGFloat
}

extension IScreenCalculatable {
    
    func widthComputed(_ value: CGFloat) -> CGFloat {
        return value * UIScreen.main.bounds.width / 390
    }
    
    func heightComputed(_ value: CGFloat) -> CGFloat {
        return value * UIScreen.main.bounds.height / 844
    }
}
