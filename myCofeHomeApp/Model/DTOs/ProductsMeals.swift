//
//  ProductsMeals.swift
//  myCofeHomeApp
//
//  Created by Apple on 2.5.2024.
//

import Foundation

struct ProductsMeals: Decodable {
    
    let meals: [Meal]
    
    struct Meal: Decodable {
        let idMeal: String?
        let strMeal: String!
        let strMealThumb: String!
        let strArea: String!
    }
}
