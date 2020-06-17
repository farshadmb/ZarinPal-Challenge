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
    
    static let clientCredetianl = AppClientCredential(id: "c226bed88f3a6f151e69",
                                                      secret: "ec1aaeac6f1544259e9bf83632a8405fc3195ce6",
                                                      scope: "repo read:user", state: 0,
                                                      redirectURL: "zp-challenge://oauth/callback")
    
}
