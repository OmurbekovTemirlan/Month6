//
//  JasonParser.swift
//  myCofeHomeApp
//
//  Created by Apple on 29.4.2024.
//

import UIKit

struct JsonParser {
    
    enum CostumError: String, Error {
        case incorrectFormat = "Вы не правильно распарсили Json"
    }
    
    private let decoder = JSONDecoder()
    
    private let encoder = JSONEncoder()
    
    func getCategories(complition: ([ProductCategory]) -> Void ) {
        guard let path = Bundle.main.path(forResource: "Categories", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let model = try decoder.decode(ProductsCategories.self, from: data)
            print(model.categories)
            complition(model.categories)
        } catch let error {
            print("error \(error.localizedDescription)")
        }
    }
    
    func getItems<Model: Decodable> (from data: Data, complition: (Result<Model, CostumError>) -> Void ) {
        
        do {
            let model = try decoder.decode(Model.self, from: data )
            
            complition(.success(model))
        } catch {
            complition(.failure(.incorrectFormat))
        }
    }
    
}
