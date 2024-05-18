//
//  LoadImage + extension.swift
//  myCofeHomeApp
//
//  Created by Apple on 3.5.2024.
//

import UIKit

final class ImageDownloader {
    
    static let shared = ImageDownloader()
    
    private init() { }
    
    func loadImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil,
                    let image = UIImage(data: data) else { return }
            completion(.success(image))
        }.resume()
    }
}
