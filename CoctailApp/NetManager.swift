//
//  NetManager.swift
//  CoctailApp
//
//  Created by Инна Лаптева on 04.03.2020.
//  Copyright © 2020 Инна Лаптева. All rights reserved.
//

import Foundation

class NetManager {
    static let netManager = NetManager()
    
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
    }


