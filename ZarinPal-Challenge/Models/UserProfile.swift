//
//  UserProfile.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct UserProfile: Storable, Hashable {
    
    let id: String
    let name: String?
    let username: String
    let email: String?
    let avatarURL: String?
    let url: String?
    let twitterUsername: String?
    let bio: String?
    let company: String?
    let websiteURL: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case avatarURL = "avatarUrl"
        case url = "url"
        case twitterUsername = "twitterUsername"
        case bio = "bio"
        case company = "company"
        case username = "login"
        case websiteURL = "websiteUrl"
    }
}
