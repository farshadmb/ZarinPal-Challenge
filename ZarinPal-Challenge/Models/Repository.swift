//
//  Repository.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct Repository : Storable {
    
    let id: String?
    let name: String?
    let description: String?
    let starCount: Int
    let forkCount: Int
    let avatarImage: URL?
    let language: Language?
    
    enum CodingKeys: String, CodingKey {
        case node
        case id
        case name
        case description
        case starCount = "stargazers"
        case forkCount
        case avatarImage = "avatarUrl"
        case language = "primaryLanguage"
        case count
        case owner
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // node container
        let nodeContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .node)
        let starContainer = try nodeContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .starCount)
        let ownerContainer = try nodeContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .owner)
        
        id = try nodeContainer.decodeIfPresent(String.self, forKey: .id)
        name = try nodeContainer.decodeIfPresent(String.self, forKey: .name)
        description = try nodeContainer.decodeIfPresent(String.self, forKey: .description)
        forkCount = try nodeContainer.decodeIfPresent(Int.self, forKey: .forkCount) ?? 0
        language = try nodeContainer.decodeIfPresent(Language.self, forKey: .language)
        starCount = try starContainer.decodeIfPresent(Int.self, forKey: .count) ?? 0
        
        avatarImage = try ownerContainer.decodeIfPresent(URL.self, forKey: .avatarImage)
        
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
    
}

extension Repository {
    
    struct Language : Storable {
        let name: String
        let color: String?
    }
    
}
