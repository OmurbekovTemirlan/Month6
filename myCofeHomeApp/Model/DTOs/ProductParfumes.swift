//
//  ProductParfumes.swift
//  myCofeHomeApp
//
//  Created by Apple on 11.5.2024.
//

import Foundation
struct ProductResponse: Codable {
    let products: [Product]
   
    
    struct Product: Codable {
        let id: Int
        let title: String
        let description: String
        let price: Double
        let discountPercentage: Double
        let rating: Double
        let stock: Int
        let brand: String
        let category: String
        let thumbnail: String
        let images: [String]
    }
}


