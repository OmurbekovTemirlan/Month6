//
//  JasonParser.swift
//  myCofeHomeApp
//
//  Created by Apple on 29.4.2024.
//

import Foundation

struct JsonParser {
    
    enum CostumError: String, Error {
        case incorrectFormat = "Вы не правильно распарсили Json"
    }
    
    private let decoder = JSONDecoder()
    
    private let encoder = JSONEncoder()
    
    func getCategories(complition: ([CategoryModel]) -> Void ) {
        guard let path = Bundle.main.path(forResource: "Categories", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let model = try decoder.decode(Category.self, from: data)
            print(model.categories)
            complition(model.categories)
        } catch let error {
            print("error \(error.localizedDescription)")
        }
    }
    
    func getProducts(complition: ([Products.ProductsModel]) -> Void ) {
        guard let path = Bundle.main.path(forResource: "Products", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let model = try decoder.decode(Products.self, from: data )
            complition(model.products)
        } catch let error {
            print("error \(error.localizedDescription)")
        }
    }
    
    func getCakes(complition: (Result<[Products.ProductsModel], CostumError>) -> Void ) {
        guard let path = Bundle.main.path(forResource: "Cakes", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let model = try decoder.decode(Products.self, from: data )
            
            complition(.success(model.products))
        } catch {
            complition(.failure(.incorrectFormat))
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
