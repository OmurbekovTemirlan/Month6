//
//  FilteredMealsModel.swift
//  myCofeHomeApp
//
//  Created by Apple on 3.5.2024.
//

import Foundation

struct FilteredMeals: Decodable {
    
    let meals: [FilterMeal]
    
    struct FilterMeal: Decodable {
        let idMeal: String?
        let strMeal: String!
        let strMealThumb: String!
        
    }
}
