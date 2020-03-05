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
    
    
//    init(drinkDict: [String: Any]) {
//        strDrink = drinkDict["strDrink"] as? String ?? ""
//        strDrinkThumb = drinkDict["strDrinkThumb"] as? String ?? ""
//        idDrink = drinkDict["idDrink"] as? String ?? ""
//        strAlcoholic = drinkDict["strAlcoholic"] as? String
//        strInstructions = drinkDict["strInstructions"] as? String
//        strIngredient1 = drinkDict["strIngredient1"] as? String
//        strIngredient2 = drinkDict["strIngredient2"] as? String
//        strIngredient3 = drinkDict["strIngredient3"] as? String
//        strIngredient4 = drinkDict["strIngredient4"] as? String
//        strIngredient5 = drinkDict["strIngredient5"] as? String
//        strIngredient6 = drinkDict["strIngredient6"] as? String    
//        
//    }
// метод который вохвращает массив coctails
    
    static func getCourses(from jsonData: Any) -> [Coctail]? {

        guard let jsonData = jsonData as? Array<[String : Any]> else { return nil} //[[String : Any]] = Array<[String : Any]>

        var coctails: [Coctail] = []
        for courseDict in jsonData {
            let coctail = Coctail(strDrink: "",
                                  strDrinkThumb: "",
                                  idDrink: "",
                                  strAlcoholic: "",
                                  strInstructions: "",
                                  strIngredient1: "",
                                  strIngredient2: "",
                                  strIngredient3: "",
                                  strIngredient4: "",
                                  strIngredient5: "",
                                  strIngredient6: "")
            coctails.append(coctail)
        }
        return  coctails
    }
    
    
}

struct Drinks: Decodable {
    var drinks: [Coctail]
    
}

