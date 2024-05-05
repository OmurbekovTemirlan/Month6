//
//  CategoriesModel.swift
//  myCofeHomeApp
//
//  Created by Apple on 29.4.2024.
//

import Foundation

struct CategoriesModel: Decodable {
    let categories: [Category]
    
    struct Category: Decodable {
        let categoryName: String
    }
}




