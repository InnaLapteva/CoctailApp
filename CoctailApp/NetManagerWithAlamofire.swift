//
//  NetManagerWithAlamofire.swift
//  CoctailApp
//
//  Created by Manager on 05/03/2020.
//  Copyright © 2020 Инна Лаптева. All rights reserved.
//

import UIKit
import Alamofire

class NetManagerWithAlamofire {
    static let shared = NetManagerWithAlamofire()
    
    func fetchDataWithAlamofire(from url: String) {
        
        request(url).validate().responseJSON { (dataResponse) in
            switch dataResponse.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
