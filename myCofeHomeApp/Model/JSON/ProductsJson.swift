//
//  ProductsJson.swift
//  myCofeHomeApp
//
//  Created by Apple on 29.4.2024.
//

import Foundation

let json = """
  {
      "categories": [
      {
      "categoryName": "Кофе"
      },
      {
       "categoryName": "Дессерт"
       },
      {
      "categoryName": "Выпечка"
      },
      {
      "categoryName": "Коктейлы"
      },
      {
      "categoryName": "Торты"
      },
       ]
  }
"""

let jsonData = json.data(using: .utf8)
