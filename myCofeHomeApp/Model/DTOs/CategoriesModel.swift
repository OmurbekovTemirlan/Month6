//
//  CategoriesModel.swift
//  myCofeHomeApp
//
//  Created by Apple on 29.4.2024.
//

import Foundation

struct Category: Decodable {
    let categories: [CategoryModel]
}

struct CategoryModel: Decodable {
    let categoryName: String
}
