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
    
    func setShadow(cell: CoctailCell) {
        
        cell.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 200, alpha: 0.5)
        cell.layer.shadowRadius = 10
        
    }
    
    func configure(with coctail: Coctail) {
        
        backgroundColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.8)
        
        label.text = coctail.strDrink
        
        DispatchQueue.global().async {
            guard let url = URL(string: coctail.strDrinkThumb) else {return}
            guard let imageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.imageOfCoctail.image = UIImage(data: imageData)
            }
        }
        
    }
}

