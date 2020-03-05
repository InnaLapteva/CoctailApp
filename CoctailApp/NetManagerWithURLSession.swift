//
//  NetManager.swift
//  CoctailApp
//
//  Created by Инна Лаптева on 04.03.2020.
//  Copyright © 2020 Инна Лаптева. All rights reserved.
//

import UIKit
import Alamofire

class NetManagerWithURLSession {
    
    static let shared = NetManagerWithURLSession()
 
    func fetchData(from urlString: String, with complition: @escaping (Drinks) -> Void) {
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            do {
                let receivedDrinks = try decoder.decode(Drinks.self, from: data)
                complition(receivedDrinks)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchImage(from urlString: String, for imageView: UIImageView) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error { print(error); return }
            if let response = response { print(response) }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }.resume()
        
    }
}


