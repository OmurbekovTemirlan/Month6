//
//  ProductsMeals.swift
//  myCofeHomeApp
//
//  Created by Apple on 2.5.2024.
//

import Foundation

struct ProductsMeals: Codable {
    
    let meals: [Meal]
}
struct Meal: Codable {
    let idMeal: String?
    let strMeal: String?
    let strMealThumb: String?
    let strArea: String?
    let strInstructions: String?
}
