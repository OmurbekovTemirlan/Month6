//
//  ProductCategories.swift
//  myCofeHomeApp
//
//  Created by Apple on 1.5.2024.
//

struct ProductsCategories: Codable {
    let categories: [ProductCategory]

}
struct ProductCategory: Codable {
    let strCategory: String
   
}
