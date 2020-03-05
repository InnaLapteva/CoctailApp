//
//  DetailedViewController.swift
//  CoctailApp
//
//  Created by Инна Лаптева on 29.02.2020.
//  Copyright © 2020 Инна Лаптева. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var imageOfCoctail: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var ingridientsLabel: UILabel!
    @IBOutlet weak var alcoLabel: UILabel!
    
    
    var coctail: Coctail!
    var detailedJSON: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namelabel.text = coctail.strDrink
        detailedJSON = getDetailedJson()
        
        NetManagerWithURLSession.shared.fetchImage(from: coctail.strDrinkThumb, for: imageOfCoctail)
        
        NetManagerWithURLSession.shared.fetchData(from: detailedJSON) { (reciveDrink) in
            DispatchQueue.main.async {
                self.coctail = reciveDrink.drinks.first
            self.instructionLabel.text = "Instruction: \(reciveDrink.drinks.first?.strInstructions ?? "not found")"
            self.alcoLabel.text = reciveDrink.drinks.first?.strAlcoholic
            self.ingridientsLabel.text = "Ingridients: \(reciveDrink.drinks.first?.ingredients ?? "not found")"
        }
       
        } }
    
    //MARK: Private methods
    private func getDetailedJson() -> String {
        
        let idDrink = coctail.idDrink
        let detailedJson = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(idDrink)"
        print(detailedJson)
        return detailedJson
        
    }

}

