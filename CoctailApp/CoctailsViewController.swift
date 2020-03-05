//
//  CoctailsViewController.swift
//  CoctailApp
//
//  Created by Инна Лаптева on 28.02.2020.
//  Copyright © 2020 Инна Лаптева. All rights reserved.
//

import UIKit
import Alamofire


class CoctailsViewController: UICollectionViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var receivedDrinks: Drinks?
    
    private let jsonUrl = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchDataAlamofire()
//        NetManagerWithURLSession.shared.fetchData(from: jsonUrl) { (receiveDrinks) in
//            DispatchQueue.main.async {
//                self.receivedDrinks = receiveDrinks
//                self.collectionView.reloadData()
//            }
//        }
    }
    
    // MARK: UICollectionViewDataSource
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let coctails = receivedDrinks?.drinks else {return 0}
        return coctails.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CoctailCell
        let coctail = receivedDrinks?.drinks[indexPath.item]
        cell.label.text = coctail?.strDrink
        cell.configure(with: coctail ?? Coctail(strDrink: "",
                                                strDrinkThumb: "",
                                                idDrink: "",
                                                strAlcoholic: "",
                                                strInstructions: "",
                                                strIngredient1: "",
                                                strIngredient2: "",
                                                strIngredient3: "",
                                                strIngredient4: "",
                                                strIngredient5: "",
                                                strIngredient6: ""))
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coctail = receivedDrinks?.drinks[indexPath.item]
        performSegue(withIdentifier: "DetailedSegue", sender: coctail)} 
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        if segue.identifier == "DetailedSegue" {
            let dvc = segue.destination as! DetailedViewController
            dvc.coctail = sender as? Coctail
        }
    }
    
    //MARK: Privet methods
    private func fetchDataAlamofire() {
        
        request(jsonUrl).validate().responseJSON { (dataResponse) in
            switch dataResponse.result {
            case .success(let value):
                print(value)
                guard let jsonData = value as? Array<[String : Array<[String : Any]>]> else {return print("not working")} //[[String : Any]] = Array<[String : Any]>
                print(jsonData)
                for coctailDict in jsonData {
                    
//                    let coctail = Coctail(strDrink: coctailDict["strDrink"] as? String ?? "",
//                                          strDrinkThumb: coctailDict["strDrinkThumb"] as? String ?? "",
//                                          idDrink: coctailDict["idDrink"] as? String ?? "",
//                                          strAlcoholic: coctailDict["strAlcoholic"] as? String,
//                                          strInstructions: coctailDict["strInstructions"] as? String,
//                                          strIngredient1: coctailDict["strIngredient1"] as? String,
//                                          strIngredient2: coctailDict["strIngredient2"] as? String,
//                                          strIngredient3: coctailDict["strIngredient3"] as? String,
//                                          strIngredient4: coctailDict["strIngredient4"] as? String,
//                                          strIngredient5: coctailDict["strIngredient5"] as? String,
//                                          strIngredient6: coctailDict["strIngredient6"] as? String)
//
//                    self.receivedDrinks?.drinks.append(coctail)
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
        
        
    }
}


extension CoctailsViewController: UICollectionViewDelegateFlowLayout {
    //задаем ширину ячейки, опираяся на ширину экрана
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.width - 40) / 2, height: (UIScreen.main.bounds.width - 40) / 2)
        
    }
    
}
