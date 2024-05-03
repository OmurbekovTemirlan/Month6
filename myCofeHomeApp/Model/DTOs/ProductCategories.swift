//
//  ProductCategories.swift
//  myCofeHomeApp
//
//  Created by Apple on 1.5.2024.
//

struct ProductsCategories: Decodable {
    let categories: [ProductCategory]
    
    struct ProductCategory: Decodable {
        let strCategory: String
       
    }

}

