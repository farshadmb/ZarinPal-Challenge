//
//  AppClientCredential.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

protocol GitClientCredential: Encodable {
    var id: String { get }
    var secret: String { get }
    var scope: String { get }
    var state: Int { get }
    var redirectURL: String { get }
}

struct AppClientCredential: Encodable, GitClientCredential {
    
    var id: String
    var secret: String
    var scope: String
    var state: Int
    var redirectURL: String
    var code: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id = "client_id"
        case secret = "client_secret"
        case scope
        case state
        case redirectURL = "redirect_url"
        case code
    }
    
}
