//
//  NetworkService.swift
//  myCofeHomeApp
//
//  Created by Apple on 1.5.2024.
//

import Foundation

struct NetworkService {
    
    enum HttpMethods: String {
        case GET, POST, PUT, DELETE
    }
    
    private let decoder = JSONDecoder()
    
    func getCategories(complition: @escaping (Result<[ProductCategory], Error>) -> Void) {
        let request = URLRequest(url: Constants.baseURL.appendingPathComponent("categories.php"))
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                complition(.failure(error))
                return
            }
            
            guard let data = data else {
                complition(.failure(error!))
                return
            }
            
            do {
                let model = try decoder.decode(ProductsCategories.self, from: data)
                complition(.success(model.categories))
            } catch {
                complition(.failure(error))
               
            }
        }.resume()
    }
    
    func getProducts(with category: String, complition: @escaping (Result<[Meal], Error>) -> Void) {
        
        var urlComponents = URLComponents(url:  Constants.baseURL.appendingPathComponent("filter.php"), resolvingAgainstBaseURL: false)
        
        urlComponents?.queryItems = [ URLQueryItem(name: "c", value: category)]
        
        guard let url = urlComponents?.url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                complition(.failure(error))
                return
            }
            
            guard let data = data else {
                complition(.failure(error!))
                return
            }
            
            do {
                let model = try decoder.decode(ProductsMeals.self, from: data)
                complition(.success(model.meals))
            } catch {
                complition(.failure(error))
             
            }
        }.resume()
    }
    
    func getProductDetails(with productId: String, complition: @escaping (Result<Meal, Error>) -> Void) {
        
        var urlComponents = URLComponents(url:  Constants.baseURL.appendingPathComponent("lookup.php"), resolvingAgainstBaseURL: false)
        
        urlComponents?.queryItems = [ URLQueryItem(name: "i", value: productId)]
        
        guard let url = urlComponents?.url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                complition(.failure(error))
                return
            }
            
            guard let data = data else {
                complition(.failure(error!))
                return
            }
            
            do {
                let model = try decoder.decode(ProductsMeals.self, from: data)
                if let mealDetail = model.meals.first {
                    complition(.success(mealDetail))
                }
            } catch {
                complition(.failure(error))
               
            }
        }.resume()
    }
    
    
    func searchProducts(with title: String, complition: @escaping (Result<[Meal], Error>) -> Void) {
        
        var urlComponents = URLComponents(url:  Constants.baseURL.appendingPathComponent("search.php"), resolvingAgainstBaseURL: false)
        
        urlComponents?.queryItems = [ URLQueryItem(name: "s", value: title)]
        
        guard let url = urlComponents?.url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                complition(.failure(error))
                return
            }
            
            guard let data = data else {
                complition(.failure(error!))
                return
            }
            
            do {
                let model = try decoder.decode(ProductsMeals.self, from: data)
                complition(.success(model.meals))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
    
    func fetchProducts(
        limit: Int,
        skip: Int,
        complition: @escaping (Result<[ProductResponse.Product], Error>) -> Void
    ) {
        
        let url = URL(string: "https://dummyjson.com/products")!
        
        var urlComponents = URLComponents(url:  url, resolvingAgainstBaseURL: false)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "skip", value: String(skip))
        ]
        
        guard let url = urlComponents?.url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                complition(.failure(error))
                return
            }
            
            guard let data = data else {
                complition(.failure(error!))
               
                
                return
            }
            
            do {
                let model = try decoder.decode(ProductResponse.self, from: data)
                complition(.success(model.products))
               
                
            } catch {
                complition(.failure(error))
               
            }
        }.resume()
    }

}
