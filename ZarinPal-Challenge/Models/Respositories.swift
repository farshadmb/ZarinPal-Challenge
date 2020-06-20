//
//  Respositories.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct Repositories: Decodable {
    
    let repositores: [Repository]
    let page: Pagination
    let totalCount: Int
    
    enum JSONCodingKeys: String, CodingKey {
        case repositores = "repositories"
        case page = "pageInfo"
        case totalCount
        case edges
    }
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: JSONCodingKeys.self)
        let repositoriesContainer = try rootContainer.nestedContainer(keyedBy: JSONCodingKeys.self, forKey: .repositores)
        
        page = try repositoriesContainer.decode(Pagination.self, forKey: .page)
        totalCount = try repositoriesContainer.decode(Int.self, forKey: .totalCount)
        
//        let edgesContainer = try repositoriesContainer.nestedUnkeyedContainer(forKey: .edges)
        
        repositores = try repositoriesContainer.decodeIfPresent([Repository].self, forKey: .edges) ?? []
        
    }
    
}
