//
//  CoctailsViewController.swift
//  CoctailApp
//
//  Created by Инна Лаптева on 28.02.2020.
//  Copyright © 2020 Инна Лаптева. All rights reserved.
//

import UIKit



class CoctailsViewController: UICollectionViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var receivedDrinks: Drinks = Drinks(drinks: [Coctail(strDrink: "", strDrinkThumb: "", idDrink: "", strAlcoholic: "", strInstructions: "", strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "")])
    
    private let jsonUrl = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
       // fetchData()
        NetManager.netManager.fetchData(from: jsonUrl) { (receiveDrinks) in
            DispatchQueue.main.async {
                self.receivedDrinks = receiveDrinks
                self.collectionView.reloadData()
                
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return receivedDrinks.drinks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CoctailCell
        let coctail = receivedDrinks.drinks[indexPath.item]
        cell.label.text = coctail.strDrink
        cell.configure(with: coctail)
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }

        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coctail = receivedDrinks.drinks[indexPath.item]
        performSegue(withIdentifier: "DetailedSegue", sender: coctail)} 
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        if segue.identifier == "DetailedSegue" {
            let dvc = segue.destination as! DetailedViewController
            dvc.coctail = sender as? Coctail
        }
    }

    //MARK: Private method
    
    private func fetchData() {
        guard let url = URL(string: jsonUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            do {
                self.receivedDrinks = try decoder.decode(Drinks.self, from: data)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                // print(self.receivedDrinks)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


extension CoctailsViewController: UICollectionViewDelegateFlowLayout {
    //задаем ширину ячейки, опираяся на ширину экрана
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.width - 40) / 2, height: (UIScreen.main.bounds.width - 40) / 2)
        
    }
    
}
