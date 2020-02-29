//
//  Coctail.swift
//  CoctailApp
//
//  Created by Инна Лаптева on 28.02.2020.
//  Copyright © 2020 Инна Лаптева. All rights reserved.
//

struct Coctail: Decodable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
    
    let strAlcoholic: String?
       let strInstructions: String?
       let strIngredient1: String?
       let strIngredient2: String?
       let strIngredient3: String?
       let strIngredient4: String?
       let strIngredient5: String?
       let strIngredient6: String?
    
    var ingredients: String? {
        "\(strIngredient1 ?? "") \(strIngredient2 ?? "") \(strIngredient3 ?? "") \(strIngredient4 ?? "") \(strIngredient5 ?? "") \(strIngredient6 ?? "") "
    }
    
       }

struct Drinks: Decodable {
    let drinks: [Coctail]
}

