//
//  ProductsModel.swift
//  myCofeHomeApp
//
//  Created by Apple on 29.4.2024.
//

import Foundation

struct Products: Decodable {
    
    let products: [ProductsModel]
    
    struct ProductsModel: Decodable {
        let image: String
        let title: String
        let infoLab: String
        let price: Int
    }
}
