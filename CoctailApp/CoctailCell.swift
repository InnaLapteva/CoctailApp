//
//  CoctailCell.swift
//  CoctailApp
//
//  Created by Инна Лаптева on 28.02.2020.
//  Copyright © 2020 Инна Лаптева. All rights reserved.
//

import UIKit

class CoctailCell: UICollectionViewCell {
    
    @IBOutlet weak var imageOfCoctail: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func configure(with coctail: Coctail) {
        
        label.text = coctail.strDrink
        
        DispatchQueue.global().async {
            guard let url = URL(string: coctail.strDrink) else {return}
            guard let imageData = try? Data(contentsOf: url) else {return}
            print(imageData)
            
            DispatchQueue.main.async {
               
                self.imageOfCoctail.image = UIImage(data: imageData)
            }
        }
    }

}
