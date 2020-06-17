//
//  OAuthCredential.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct OAuthCredential: Storable {
    
    let accessToken: String
    let refreshToken: String?
    
    let tokenType: String
    let scope: String?
    let userId: String?
    let expiration: Date?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case scope = "scope"
        case userId = "userId"
        case expiration = "expiration"
    }
    
    // Require refresh if within 5 minutes of expiration
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5) > expiration ?? Date() }
    
    var header: String {
        return "\(tokenType.capitalized) \(accessToken)"
    }
}
