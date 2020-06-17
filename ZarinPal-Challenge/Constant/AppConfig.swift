//
//  AppConfig.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct AppConfig {
    
    static let baseURL: URL = {
        
        guard let baseURL = URL(string: "https://api.github.com") else {
            fatalError("Can not build baseURL")
        }
        
        return baseURL
    }()
    
}
